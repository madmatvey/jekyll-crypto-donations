# frozen_string_literal: true

require "spec_helper"

RSpec.describe Jekyll::CryptoDonations::DonationsTag do
  let(:site_config) do
    {
      "btc_address" => "btc_test_address",
      "eth_address" => "eth_test_address",
      "usdt_address" => "usdt_test_address"
    }
  end

  let(:context) do
    make_context(site_config)
  end
  let(:tag) { Liquid::Template.parse("{% crypto_donations Additional text %}").render(context) }

  describe "#render" do
    it "returns the HTML with all donation addresses" do
      expect(tag).to include("Support Us with Crypto Donations")
      expect(tag).to include("Additional text")
      expect(tag).to include("btc_test_address")
      expect(tag).to include("eth_test_address")
      expect(tag).to include("usdt_test_address")
      expect(tag).to include("getDonations('btc', 'btc_test_address')")
      expect(tag).to include("getDonations('eth', 'eth_test_address')")
      expect(tag).to include("getDonations('usdt', 'usdt_test_address')")
    end

    context "when config not includes BTC address" do
      let(:site_config) do
        {
          "eth_address" => "eth_test_address",
          "usdt_address" => "usdt_test_address"
        }
      end

      it "does not include BTC section" do
        expect(tag).not_to include("Bitcoin (BTC)")
        expect(tag).not_to include("btc_test_address")
        expect(tag).not_to include("getDonations('btc', 'btc_test_address')")
      end
    end

    context "when config not includes ETH address" do
      let(:site_config) do
        {
          "btc_address" => "btc_test_address",
          "usdt_address" => "usdt_test_address"
        }
      end

      it "does not include ETH section" do
        expect(tag).not_to include("Ethereum (ETH)")
        expect(tag).not_to include("eth_test_address")
        expect(tag).not_to include("getDonations('eth', 'eth_test_address')")
      end
    end

    context "when config not includes USDT address" do
      let(:site_config) do
        {
          "btc_address" => "btc_test_address",
          "eth_address" => "eth_test_address"
        }
      end

      it "does not include USDT section" do
        expect(tag).not_to include("USDT (TRC-20)")
        expect(tag).not_to include("usdt_test_address")
        expect(tag).not_to include("getDonations('usdt', 'usdt_test_address')")
      end
    end

    context "when no donation addresses are provided" do
      let(:site_config) do
        {}
      end
      it "returns empty string" do
        expect(tag).to be_empty
      end
    end
  end
end
