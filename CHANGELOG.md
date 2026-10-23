# Version 0.3.0

* All migrations have been moved to one file. If upgrading, you will have to manage this.
* A new Antispam::Signups model has been created to make it easier to track and categorize account creation actions.

# Version 0.3.1-3

* Better description for RubyGems.org

# Version 0.3.4

* Fix Defendium JSON parsing.

# Version 0.3.5

* `Antispam::Signup.analyze` accepts an optional `request:`; the IP comes from `request.remote_ip` unless `ip:` is given.
* New `Antispam::Signup.check_spam(user_id:, request:)` returns a hash including the Defendium human check. `:safe` is true only when the signup score is safe and Defendium returns "pass".
