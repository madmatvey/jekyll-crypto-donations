# frozen_string_literal: true

require "jekyll-crypto-donations"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require "jekyll"

Jekyll.logger = Logger.new(StringIO.new)

def make_site
  Jekyll::Site.new(Jekyll.configuration)
end

def make_context(value = nil)
  site = make_site
  site.config["crypto_donations"] = value
  Liquid::Context.new({}, {}, site: site)
end
