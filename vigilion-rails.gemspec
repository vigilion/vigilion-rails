$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "vigilion-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "vigilion-rails"
  s.version     = VigilionRails::VERSION
  s.authors     = ["Bit Zesty Ltd"]
  s.email       = ["help@vigilion.com"]
  s.homepage    = "https://github.com/vigilion/vigilion-rails"
  s.summary     = "Rails engine for Vigilion Anti-Virus & Malware file scanning service."
  s.description = "Rails engine for Vigilion Anti-Virus & Malware file scanning service."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "vigilion", "~> 1.0.3"

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'sqlite3'
end
