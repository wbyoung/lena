$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lena/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lena"
  s.license     = "MIT"
  s.version     = Lena::VERSION
  s.authors     = ["Whitney Young"]
  s.email       = ["wbyoung@gmail.com"]
  s.homepage    = "https://github.com/wbyoung/lena"
  s.summary     = "Remote JavaScript logging for Rails applications."
  s.description = "Remote JavaScript logging for Rails applications."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '~> 4.0.0'
  s.add_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'jasmine-rails'
  s.add_development_dependency 'coveralls'
end
