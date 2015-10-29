require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @inactive_nontech = employees(:inactive_nontech)
    @inactive_tech = employees(:inactive_tech)
  end

  test 'login page is accessible when not logged in' do
    get :new
    assert_response :success
  end

  test 'inactive non-techs cannot log in' do
    post :create, session: { username: @inactive_nontech.username, password: 'password' }
    assert_nil session[:employee_id]
    assert_template :new
    assert_equal 'Your account is currently inactive!', flash[:danger]
  end

  test 'inactive techs cannot log in' do
    post :create, session: { username: @inactive_tech.username, password: 'password' }
    assert_nil session[:employee_id]
    assert_template :new
    assert_equal 'Your account is currently inactive!', flash[:danger]
  end

end
