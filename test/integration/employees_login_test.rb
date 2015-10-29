require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest

  def setup
    @active_nontech = employees(:active_nontech)
    @active_tech = employees(:active_tech)
    @inactive_nontech = employees(:inactive_nontech)
    @inactive_tech = employees(:inactive_tech)
  end

  test 'active non-techs can log in' do
    get login_path
    log_in_testenv(@active_nontech)
    assert_not_nil session[:employee_id]
    assert_redirected_to my_tickets_path
  end

  # test 'inactive employees should not be able to log in' do
  #   log_in_testenv(@inactive_nontech)
  #
  # end

end
