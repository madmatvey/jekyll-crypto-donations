# frozen_string_literal: true

require "jekyll"
require "jekyll-crypto-donations/version"
# require "jekyll_crypto_donations/generator"

module Jekyll
  module CryptoDonations
    # describe {% crypto_donations %} tag content
    class DonationsTag < Liquid::Tag # rubocop:disable Metrics/ClassLength
      attr_reader :btc_address, :eth_address, :usdt_address

      CRYPTO_CURRENCIES = {
        btc: { name: "Bitcoin", ticker: "BTC" },
        eth: { name: "Ethereum", ticker: "ETH" },
        usdt: { name: "Tether", ticker: "USDT TRC-20" }
      }.freeze

      def initialize(tag_name, text, tokens)
        super
        @text = text
      end

      def currency_html(currency_ticker, address)
        currency = CRYPTO_CURRENCIES[currency_ticker]
        <<~HTML
          <div class="jekyll-crypto-donations__item">
            <span class="jekyll-crypto-donations__crypto-name">#{currency[:name]} (#{currency[:ticker]})</span>
            <div class="jekyll-crypto-donations__crypto">
              <div class="jekyll-crypto-donations__crypto-value">
                <div class="jekyll-crypto-donations__crypto-code">
                  <span>#{address}</span>
                </div>
                <div class="jekyll-crypto-donations__crypto-buttons">
                  <button class="jekyll-crypto-donations__crypto-btn-copy">
                    <svg id="svg" fill="#ededed" stroke="#ededed" width="20" height="20" version="1.1" viewBox="144 144 512 512" xmlns="http://www.w3.org/2000/svg" stroke-width="20">
                      <g id="IconSvg_bgCarrier" stroke-width="0"></g>
                      <g id="IconSvg_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" stroke="#CCCCCC" stroke-width="0">
                        <g xmlns="http://www.w3.org/2000/svg">
                          <path d="m458.74 466.8h123.13 17.23c5.4414 0 10.078-4.6367 10.078-10.078v-86.957-139.15-31.84c0-5.4414-4.6367-10.078-10.078-10.078h-87.359-138.95-31.641c-5.4414 0-10.078 4.6367-10.078 10.078v126.66 17.938c0 13 20.152 13 20.152 0v-126.66-17.938c-3.3242 3.3242-6.75 6.75-10.078 10.078h87.359 138.95 31.641c-3.3242-3.3242-6.75-6.75-10.078-10.078v86.957 139.15 31.84l10.078-10.078h-123.13-17.23c-12.992 0.003906-12.992 20.156 0.003907 20.156z"></path>
                          <path d="m458.74 591.14h-86.957-139.15-31.84l10.078 10.078v-86.957-139.15-31.84c-3.3242 3.3242-6.75 6.75-10.078 10.078h86.957 139.15 31.84c-3.3242-3.3242-6.75-6.75-10.078-10.078v86.957 139.15 31.84c0 13 20.152 13 20.152 0v-86.957-139.15-31.84c0-5.4414-4.6367-10.078-10.078-10.078h-86.957-139.15-31.84c-5.4414 0-10.078 4.6367-10.078 10.078v86.957 139.15 31.84c0 5.4414 4.6367 10.078 10.078 10.078h86.957 139.15 31.84c13.004-0.003906 13.004-20.156 0.003907-20.156z"></path>
                        </g>
                      </g>
                      <g id="IconSvg_iconCarrier">
                        <g xmlns="http://www.w3.org/2000/svg">
                          <path d="m458.74 466.8h123.13 17.23c5.4414 0 10.078-4.6367 10.078-10.078v-86.957-139.15-31.84c0-5.4414-4.6367-10.078-10.078-10.078h-87.359-138.95-31.641c-5.4414 0-10.078 4.6367-10.078 10.078v126.66 17.938c0 13 20.152 13 20.152 0v-126.66-17.938c-3.3242 3.3242-6.75 6.75-10.078 10.078h87.359 138.95 31.641c-3.3242-3.3242-6.75-6.75-10.078-10.078v86.957 139.15 31.84l10.078-10.078h-123.13-17.23c-12.992 0.003906-12.992 20.156 0.003907 20.156z"></path>
                          <path d="m458.74 591.14h-86.957-139.15-31.84l10.078 10.078v-86.957-139.15-31.84c-3.3242 3.3242-6.75 6.75-10.078 10.078h86.957 139.15 31.84c-3.3242-3.3242-6.75-6.75-10.078-10.078v86.957 139.15 31.84c0 13 20.152 13 20.152 0v-86.957-139.15-31.84c0-5.4414-4.6367-10.078-10.078-10.078h-86.957-139.15-31.84c-5.4414 0-10.078 4.6367-10.078 10.078v86.957 139.15 31.84c0 5.4414 4.6367 10.078 10.078 10.078h86.957 139.15 31.84c13.004-0.003906 13.004-20.156 0.003907-20.156z"></path>
                        </g>
                      </g>
                    </svg>
                  </button>
                  <button class="jekyll-crypto-donations__crypto-btn-qr">
                    <svg id="svg" fill="#ededed" stroke="#ededed" width="20" height="20" version="1.1" viewBox="144 144 512 512" xmlns="http://www.w3.org/2000/svg" stroke-width="0">
                      <g id="IconSvg_bgCarrier" stroke-width="0"></g>
                      <g id="IconSvg_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" stroke="#CCCCCC" stroke-width="0">
                        <g xmlns="http://www.w3.org/2000/svg">
                          <path d="m379.01 588.93h-167.94v-167.93h167.94zm-125.95-41.984h83.969v-83.965h-83.969z"></path>
                          <path d="m588.93 379.01h-167.93v-167.94h167.94zm-125.95-41.984h83.969l-0.003906-83.969h-83.965z"></path>
                          <path d="m379.01 379.01h-167.94v-167.94h167.94zm-125.95-41.984h83.969v-83.969h-83.969z"></path>
                          <path d="m588.93 588.93h-83.969v-41.984h41.984v-41.984h41.984z"></path>
                          <path d="m462.98 588.93h-41.984v-83.969h41.984v-41.98h41.98v83.965h-41.98z"></path>
                          <path d="m420.99 420.99h41.984v41.984h-41.984z"></path>
                          <path d="m504.96 420.99h83.969v41.984h-83.969z"></path>
                        </g>
                      </g>
                      <g id="IconSvg_iconCarrier">
                        <g xmlns="http://www.w3.org/2000/svg">
                          <path d="m379.01 588.93h-167.94v-167.93h167.94zm-125.95-41.984h83.969v-83.965h-83.969z"></path>
                          <path d="m588.93 379.01h-167.93v-167.94h167.94zm-125.95-41.984h83.969l-0.003906-83.969h-83.965z"></path>
                          <path d="m379.01 379.01h-167.94v-167.94h167.94zm-125.95-41.984h83.969v-83.969h-83.969z"></path>
                          <path d="m588.93 588.93h-83.969v-41.984h41.984v-41.984h41.984z"></path>
                          <path d="m462.98 588.93h-41.984v-83.969h41.984v-41.98h41.98v83.965h-41.98z"></path>
                          <path d="m420.99 420.99h41.984v41.984h-41.984z"></path>
                          <path d="m504.96 420.99h83.969v41.984h-83.969z"></path>
                        </g>
                      </g>
                    </svg>
                  </button>
                  <div class="jekyll-crypto-donations__crypto-total-received">
                    <span id="jekyll-crypto-donations_#{currency_ticker}-total">Loading...</span>
                  </div>
                </div>
              </div>
              <div class="jekyll-crypto-donations__crypto-image-qr">
                <img alt="" width="150px" heght="150px" src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=#{address}">
              </div>
            </div>
          </div>
        HTML
      end

      def btc_html
        return "" unless btc_address

        currency_html(:btc, btc_address)
      end

      def eth_html
        return "" unless eth_address

        currency_html(:eth, eth_address)
      end

      def usdt_html
        return "" unless usdt_address

        currency_html(:usdt, usdt_address)
      end

      def btc_js
        return "" unless btc_address

        <<~JS
          const btcDonations = await getDonations('btc', '#{btc_address}');
          document.getElementById('jekyll-crypto-donations_btc-total').innerText = `Total received: ${btcDonations} BTC`;
        JS
      end

      def eth_js
        return "" unless eth_address

        <<~JS
          const ethDonations = await getDonations('eth', '#{eth_address}');
          document.getElementById('jekyll-crypto-donations_eth-total').innerText = `Total received: ${ethDonations} ETH`;
        JS
      end

      def usdt_js
        return "" unless usdt_address

        <<~JS
          const usdtDonations = await getDonations('usdt', '#{usdt_address}');
          document.getElementById('jekyll-crypto-donations_usdt-total').innerText = `Total received: ${usdtDonations} USDT`;
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
          <div id="jekyll-crypto-donations">
            <div class="jekyll-crypto-donations__description">
              <span>#{@text}</span>
            </div>
        HTML
      end

      def closing_html
        <<~HTML
          </div>
          <script type="module">
            import { getDonations } from '/assets/js/crypto-donations/crypto-donations.js';
            document.addEventListener('DOMContentLoaded', function () {
              document.querySelectorAll('.jekyll-crypto-donations__item').forEach((item) => {
                item.querySelector('.jekyll-crypto-donations__crypto-btn-copy').addEventListener('click', () => {
                  const code = item.querySelector('.jekyll-crypto-donations__crypto-code');
                  navigator.clipboard.writeText(code.innerText);
                  code.classList.add('jekyll-crypto-donations__crypto-code--is-copied');
                  setTimeout(() => {
                    code.classList.remove('jekyll-crypto-donations__crypto-code--is-copied');
                  }, 1500);
                });

                item.querySelector('.jekyll-crypto-donations__crypto-btn-qr').addEventListener('click', () => {
                  item.querySelector('.jekyll-crypto-donations__crypto').classList.toggle('jekyll-crypto-donations__crypto--show-qr');
                });
              });
            });

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

  source_css = File.expand_path("../assets/css/crypto-donations/crypto-donations.css", __dir__)
  destination_css = File.join(site.dest, "assets/css/crypto-donations.css")
  FileUtils.mkdir_p(File.dirname(destination_css))
  FileUtils.cp(source_css, destination_css)
end

Jekyll::Hooks.register :documents, :pre_render do |document|
  if document.output_ext == ".html"
    document.content = <<~HTML + document.content # rubocop:disable Style/StringConcatenation
      <link rel="stylesheet" href="/assets/css/crypto-donations.css">
    HTML
  end
end
