require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @active_nontech = employees(:active_nontech)
    @active_tech = employees(:active_tech)
    @inactive_nontech = employees(:inactive_nontech)
    @inactive_tech = employees(:inactive_tech)
  end

  test 'login page is accessible when not logged in' do
    get :new
    assert_response :success
  end

  test 'active non-techs cannot log in with an incorrect password' do
    post :create, session: { username: @active_nontech.username, password: 'badpassword' }
    assert_nil session[:employee_id]
    assert_template :new
    assert_equal 'Invalid credentials!', flash[:danger]
  end

  test 'active techs cannot log in with an incorrect password' do
    post :create, session: { username: @active_tech.username, password: 'badpassword' }
    assert_nil session[:employee_id]
    assert_template :new
    assert_equal 'Invalid credentials!', flash[:danger]
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
