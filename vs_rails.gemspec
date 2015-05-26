$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "vs_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "vs_rails"
  s.version     = VigilionRails::VERSION
  s.authors     = ["Bit Zesty Ltd"]
  s.email       = ["info@bitzesty.com"]
  s.homepage    = "https://github.com/bitzesty/vs-rails"
  s.summary     = "Rails engine for Virus Scanner."
  s.description = "Rails engine for BitZesty's Virus Scanner service."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "4.2.0"
  s.add_dependency "virus-scanner", "~> 0.0.5"

  s.add_development_dependency "sqlite3"
end
