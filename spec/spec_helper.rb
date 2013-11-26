require 'coveralls'

# Enable Coveralls
Coveralls.wear!

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara-webkit'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("../support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

# Support use of to and to_not in one-liners allowing use of `expect_it { to ... }`
# syntax when should has been disabled.
RSpec::Core::MemoizedHelpers.module_eval do
  alias to should
  alias to_not should_not
end

RSpec.configure do |config|
  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Using webkit as the javascript driver
  Capybara.javascript_driver = :webkit

  # Disable should syntax.
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Support use of expect_it one-liners allowing use of `expect_it { to ... }`
  # syntax when should has been disabled.
  config.alias_example_to :expect_it
end
