require_relative "lib/antispam/version"

Gem::Specification.new do |spec|
  spec.name        = "antispam"
  spec.version     = Antispam::VERSION
  spec.authors     = ["Ryan Kopf"]
  spec.email       = ["antispam@ryankopf.com"]
  spec.homepage    = "https://ryankopf.com"
  spec.summary     = "A spam prevention gem."
  spec.description = "Antispam helps prevent spam in your Rails applications by checking against DNS blacklists and spam-prevention databases. It has two core features: (1) IP-based spam detection using Project Honey Pot to block known spammers automatically, and (2) content-based spam detection using Defendium’s machine learning API, which is free for up to 1,000 checks per day. Blacklist lookups are cached for 24 hours to minimize performance impact. The gem integrates seamlessly with Rails, allowing you to block spam at the request level and redirect flagged users to a captcha page."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ryankopf/antispam"
  spec.metadata["changelog_uri"] = "https://github.com/ryankopf/antispam/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6.1.0"
  spec.add_dependency "image_processing", "~> 1.0"
  spec.add_dependency "csv"
  spec.add_development_dependency "net-http"
end
