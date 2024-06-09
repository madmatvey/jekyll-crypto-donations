# frozen_string_literal: true

require_relative "lib/jekyll-crypto-donations/version"

Gem::Specification.new do |spec|
  spec.name = "jekyll-crypto-donations"
  spec.version = Jekyll::CryptoDonations::VERSION
  spec.authors = ["madmatvey"]
  spec.email = ["potehin@gmail.com"]

  spec.summary = "A Jekyll plugin for crypto donations"
  spec.description = "This plugin allows you to collect and display cryptocurrency donations on your Jekyll site."
  spec.homepage = "https://github.com/madmatvey/jekyll-crypto-donations"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/madmatvey/jekyll-crypto-donations.git"
  spec.metadata["changelog_uri"] = "https://github.com/madmatvey/jekyll-crypto-donations/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # all_files = `git ls-files -z`.split("\x0")
  spec.files = Dir["lib/**/*.rb"] + Dir["assets/js/**/*.js"] + Dir["assets/css/**/*.css"]
  spec.extra_rdoc_files = %w[README.md LICENSE]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_runtime_dependency "jekyll", "~> 4.3"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
