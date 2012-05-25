ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha'
require 'capybara/rails'
include FactoryGirl::Syntax::Methods

DatabaseCleaner.strategy = :truncation

class ActionDispatch::IntegrationTest
 include Capybara::DSL

 teardown do
  DatabaseCleaner.clean  
  Capybara.reset_sessions!    # Forget the (simulated) browser state
  Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
 end
 
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting

  # Add more helper methods to be used by all tests here...
  
  #setup { Sham.reset }
  
end

class ActionController::TestCase
end

require File.expand_path(File.dirname(__FILE__) + "/blueprints")
