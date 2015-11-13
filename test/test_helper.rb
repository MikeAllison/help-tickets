ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
#require "minitest/reporters"
#Minitest::Reporters.use!
require 'pry'
require 'capybara/rails'

# Patch to make SQLite compatible with integration tests
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
# End of SQLite/integration test patch

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Capybara.default_driver = :selenium

  def integration_login(user, password='password')
    visit('/')

    within('.jumbotron') do
      click_button 'Log In'
    end

    within('#loginModal') do
      fill_in 'User Name', with: user.username
      fill_in 'Password', with: password
      click_button 'Log In'
    end
  end

  def logout!
    click_link 'Log Out'
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def functional_log_in(employee)
    session[:employee_id] = employee.id
  end

  def assert_not_blank(model, attr)
    model.send("#{attr}=", '')
    assert_not model.save, "Saved #{model.class.name.upcase} with a blank #{attr.upcase}."
  end

  def should_strip_whitespace(model, attr)
    model.send("#{attr}=", '   Test   Data   ')
    model.save
    assert_equal 'Test Data', model.send(attr), "Did not strip whitespace on #{model.class.name}.#{attr}"
  end

end
