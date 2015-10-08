require 'test_helper'

class CitiesControllerTest < ActionController::TestCase

  def setup
    @c = cities(:miami)
    @nontech = employees(:nontech)
  end

  test 'should require login to access' do
    %i(index new).each do |action|
      get action
      assert_redirected_to login_path
      assert_equal 'Please sign in.', flash[:danger]
    end

    post :create
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    get :edit, id: @c.slug
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :update, id: @c.slug
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    put :update, id: @c.slug
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :hide, id: @c.slug
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]
  end

  test 'should require technician rights to access' do
    log_in(@nontech) # test/test_helper.rb

    %i(index new).each do |action|
      get action
      assert_redirected_to my_tickets_path
      assert_equal 'That action requires technician rights!', flash[:danger]
    end

    post :create
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    get :edit, id: @c.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    patch :update, id: @c.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    put :update, id: @c.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    patch :hide, id: @c.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]
  end

end
