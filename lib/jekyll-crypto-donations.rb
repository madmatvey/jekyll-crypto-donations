# frozen_string_literal: true

require "jekyll"
require "jekyll-crypto-donations/version"
# require "jekyll_crypto_donations/generator"

module Jekyll
  module CryptoDonations
    # describe {% crypto_donations %} tag content
    class DonationsTag < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def render(context)
        site_config = context.registers.fetch(:site).config
        btc_address = site_config.dig("crypto_donations", "btc_address")
        eth_address = site_config.dig("crypto_donations", "eth_address")
        usdt_address = site_config.dig("crypto_donations", "usdt_address")

        <<~HTML
          <div id="crypto-donations">
            <h2>Support Us with Crypto Donations</h2>
            <p>#{@text}</p>
            <div>
              <h3>Bitcoin (BTC)</h3>
              <p id="btc-address">#{btc_address}</p>
              <p id="btc-donations">Loading...</p>
            </div>
            <div>
              <h3>Ethereum (ETH)</h3>
              <p id="eth-address">#{eth_address}</p>
              <p id="eth-donations">Loading...</p>
            </div>
            <div>
              <h3>USDT (TRC-20)</h3>
              <p id="usdt-address">Address: #{usdt_address}</p>
              <p id="usdt-donations">Loading...</p>
            </div>
          </div>
          <script type="module">
            import { getDonations } from '/assets/js/crypto-donations/crypto-donations.js';

            document.addEventListener('DOMContentLoaded', async () => {
              const btcAddress = '#{btc_address}';
              const ethAddress = '#{eth_address}';
              const usdtAddress = '#{usdt_address}'

              const usdtDonations = await getDonations('usdt', usdtAddress);
              document.getElementById('usdt-donations').innerText = `Total received: ${usdtDonations} USDT`;

              const btcDonations = await getDonations('btc', btcAddress);
              document.getElementById('btc-donations').innerText = `Total received: ${btcDonations} BTC`;

              const ethDonations = await getDonations('eth', ethAddress);
              document.getElementById('eth-donations').innerText = `Total received: ${ethDonations} ETH`;

            });
          </script>
        HTML
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
