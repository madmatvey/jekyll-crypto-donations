# frozen_string_literal: true

RSpec.describe Jekyll::CryptoDonations do
  describe "gem things" do
    it "has a version number" do
      expect(described_class::VERSION).not_to be_nil
    end

    it "has the proper superclass" do
      expect(described_class::DonationsTag.superclass).to eq(Liquid::Tag)
    end
  end
end
