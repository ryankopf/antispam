# Antispam
Short description and motivation.

## Usage

Once installed, usage is automatic. The gem will run during any request that is not a GET request.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'antispam'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install antispam
$ rails antispam:install:migrations
$ rails db:migrate SCOPE=antispam
```
And put this in your routes.rb
```
mount Antispam::Engine => "/antispam"
```
Make sure to
```
sudo apt install libvips-tools
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ryankopf/antispam. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/antispam/blob/master/CODE_OF_CONDUCT.md).

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Antispam project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ryankopf/antispam/blob/master/CODE_OF_CONDUCT.md).
