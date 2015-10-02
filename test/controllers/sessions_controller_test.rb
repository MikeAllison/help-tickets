require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test 'login page is accessible when not logged in' do
    get :new
    assert_response :success
  end

end
