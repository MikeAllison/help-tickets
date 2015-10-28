require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
    @active_nontech = employees(:inactive_nontech)
    @active_tech = employees(:inactive_tech)
  end

  test 'login page is accessible when not logged in' do
    get :new
    assert_response :success
  end

  test 'inactive non-techs cannot log in' do
    log_in(@)
  end

  test 'inactive techs cannot log in' do

  end

end
