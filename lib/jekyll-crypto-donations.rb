# frozen_string_literal: true

require "jekyll"
require "jekyll-crypto-donations/version"
# require "jekyll_crypto_donations/generator"

module Jekyll
  module CryptoDonations
    # describe {% crypto_donations %} tag content
    class DonationsTag < Liquid::Tag
      attr_reader :btc_address, :eth_address, :usdt_address

      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def btc_html
        return "" unless btc_address

        <<~HTML
          <div>
            <h3>Bitcoin (BTC)</h3>
            <p>Address: #{btc_address}</p>
            <p id="btc-donations">Loading...</p>
          </div>
        HTML
      end

      def eth_html
        return "" unless eth_address

        <<~HTML
          <div>
            <h3>Ethereum (ETH)</h3>
            <p>Address: #{eth_address}</p>
            <p id="eth-donations">Loading...</p>
          </div>
        HTML
      end

      def usdt_html
        return "" unless usdt_address

        <<~HTML
          <div>
            <h3>USDT (TRC-20)</h3>
            <p>Address: #{usdt_address}</p>
            <p id="usdt-donations">Loading...</p>
          </div>
        HTML
      end

      def btc_js
        return "" unless btc_address

        <<~JS
          const btcDonations = await getDonations('btc', '#{btc_address}');
          document.getElementById('btc-donations').innerText = `Total received: ${btcDonations} BTC`;
        JS
      end

      def eth_js
        return "" unless eth_address

        <<~JS
          const ethDonations = await getDonations('eth', '#{eth_address}');
          document.getElementById('eth-donations').innerText = `Total received: ${ethDonations} ETH`;
        JS
      end

      def usdt_js
        return "" unless usdt_address

        <<~JS
          const usdtDonations = await getDonations('usdt', '#{usdt_address}');
          document.getElementById('usdt-donations').innerText = `Total received: ${usdtDonations} USDT`;
        JS
      end

      def site_config(context)
        site_config = context.registers.fetch(:site).config
        @btc_address = site_config.dig("crypto_donations", "btc_address")
        @eth_address = site_config.dig("crypto_donations", "eth_address")
        @usdt_address = site_config.dig("crypto_donations", "usdt_address")
      end

      def opening_html
        <<~HTML
          <div id="crypto-donations">
            <h2>Support Us with Crypto Donations</h2>
            <p>#{@text}</p>
        HTML
      end

      def closing_html
        <<~HTML
          </div>
          <script type="module">
            import { getDonations } from '/assets/js/crypto-donations/crypto-donations.js';

            document.addEventListener('DOMContentLoaded', async () => {
        HTML
      end

      def closing_js
        <<~JS
            });
          </script>
        JS
      end

      def render(context)
        site_config(context)
        return if btc_address.nil? && eth_address.nil? && usdt_address.nil?

        content = opening_html

        content += btc_html
        content += eth_html
        content += usdt_html

        content += closing_html

        content += btc_js
        content += eth_js
        content += usdt_js

        content += closing_js

        content
      end
    end
  end
end

Liquid::Template.register_tag("crypto_donations", Jekyll::CryptoDonations::DonationsTag)

Jekyll::Hooks.register :site, :post_write do |site|
  source = File.expand_path("../assets/js/crypto-donations/crypto-donations.js", __dir__)
  destination = File.join(site.dest, "assets/js/crypto-donations/crypto-donations.js")
  FileUtils.mkdir_p(File.dirname(destination))
  FileUtils.cp(source, destination)
end
