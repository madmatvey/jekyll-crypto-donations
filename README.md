# Jekyll::CryptoDonations 🤑

[![Gem Version](https://badge.fury.io/rb/jekyll-crypto-donations.svg)](https://badge.fury.io/rb/jekyll-crypto-donations)

## About

The **Jekyll Crypto Donations** plugin is a simple and efficient solution for integrating cryptocurrency donations into Jekyll-generated websites. In the initial iteration, the plugin supports Bitcoin (BTC), Ethereum (ETH), and USDT (TRC-20). It allows website owners to display current donation amounts and provide easy access for visitors to contribute using these cryptocurrencies. The plugin is designed to be easy to install and configure, making it a seamless addition to any Jekyll site. By leveraging real-time API calls, it ensures that the displayed donation amounts are always up-to-date, providing transparency and encouraging more contributions.

## Installation

Add to your Gemfile:
```ruby
group :jekyll_plugins do
  gem 'jekyll-crypto-donations' 
end
```

## Usage

Add donation addresses to your `_config.yaml`

```yaml
crypto_donations:
  btc_address: "YOUR_BTC_ADDRESS"
  eth_address: "YOUR_ETH_ADDRESS"
  usdt_address: "YOUR_USDT_TRC20_ADDRES"
```

Use `{% crypto_donations %}` or `{% crypto_donations Any text you can share with donations block %}` at the jekyll page source.

## Demo

To see the Crypto Donations plugin in action, check out the demo on my website: [madmatvey.github.io](https://madmatvey.github.io/about/#donate-me).

You can see how the donation addresses and total received amounts are displayed for Bitcoin (BTC), Ethereum (ETH), and USDT (TRC-20). The demo showcases the real-time integration and functionality of the plugin.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Use NodeJS version 20 LTS 
```bash
$ nvm use 20 --lts
```
install Typescrypt: `npm install typescript` 

Do not change `assets/js/crypto-donations/crypto-donations.js` manually, make changes with TS at `src/crypto-donations/crypto-donations.ts` and then run: 
```bash
$ npx tsc
``` 
local gem build: `gem build jekyll-crypto-donations.gemspec` 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/madmatvey/jekyll-crypto-donations.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
