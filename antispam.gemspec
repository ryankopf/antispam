require_relative "lib/antispam/version"

Gem::Specification.new do |spec|
  spec.name        = "antispam"
  spec.version     = Antispam::VERSION
  spec.authors     = ["Ryan Kopf"]
  spec.email       = ["antispam@ryankopf.com"]
  spec.homepage    = "https://ryankopf.com"
  spec.summary     = "A spam prevention gem."
  spec.description = "Antispam checks DNS blacklists and helps prevent spam on your site."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ryankopf/antispam"
  spec.metadata["changelog_uri"] = "https://github.com/ryankopf/antispam/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.0"
  spec.add_dependency "image_processing", "~> 1.0"
end
