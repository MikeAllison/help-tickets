ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
#require "minitest/reporters"
#Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def log_in_testenv(employee, password='password')
    if integration_test?
      post login_path, session: { username: employee.username, password: password }
    else
      session[:employee_id] = employee.id
    end
  end

  def integration_test?
    defined?(post_via_redirect)
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
