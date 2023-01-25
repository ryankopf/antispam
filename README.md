# Antispam
The antispam gem helps prevent spam in your Rails applications by
providing tools that check spam against powerful spam-prevention
databases, accessible for free.

The first feature checks against an IP database of spam, allowing you
to stop spammers who are prolific and have been detected on other websites.
It uses the blazing fast Defendium API to quickly determine if submitted
content is spam or not.

The second feature allows you to submit user-provided content to a spam
checking service that uses machine learning and a database of content to
determine whether the user's submitted content is spam.

## Spam Content Checking - Usage

```
result = Antispam::Checker.check(content: @comment.body)
if result.is_spam?
  @comment.save
else
  redirect_to "/access_denied"
end
```

## Bad IP Checking - Usage

The gem is used by adding this to your ApplicationController.rb

```
before_action do
  check_ip_against_database(ip_blacklists: {default: 'yourcodehere'}, verbose: true)
end
```

Codes are from the [httpbl](https://www.projecthoneypot.org/httpbl.php) at projecthoneypot.org

Once the filter is setup, everything else is handled for your application.
By default the gem will run during any request that is not a GET request.

You can change the filter to run during other requests.

```
before_action do
  check_ip_against_database(ip_blacklists: {default: 'yourcodehere'}, methods: [:get,:post,:put,:patch,:delete])
end
```

Blacklist database lookups are cached for 24 hours, and cached results won't need
to slowdown your app by additional http requests on the backend.

The gem needs to create some database tables to function; these store the cached
blacklist database lookups, and any actions caused by the gem.

You need to add this to your routes.rb
```
  mount Antispam::Engine => "/antispam"
```
You can see what IP addresses have been blocked by going to /antispam/blocks
but your ApplicationController.rb must respond to ```is_admin?``` function.


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
The gem depends on image_processing, which depends on vips. We are using vips to
generate captcha images.
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

## NO WARRANTY

THE SUBJECT SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY WARRANTY OF ANY KIND,
EITHER EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING, BUT NOT LIMITED TO,
ANY WARRANTY THAT THE SUBJECT SOFTWARE WILL CONFORM TO SPECIFICATIONS,
ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,
OR FREEDOM FROM INFRINGEMENT, ANY WARRANTY THAT THE SUBJECT SOFTWARE WILL BE
ERROR FREE, OR ANY WARRANTY THAT DOCUMENTATION, IF PROVIDED, WILL CONFORM TO
THE SUBJECT SOFTWARE. THIS SOFTWARE IS PROVIDED "AS IS." IF YOUR JURISDICTION
DOES NOT ALLOW THESE LIMITATIONS THEN YOU MAY NOT USE THE SOFTWARE.
