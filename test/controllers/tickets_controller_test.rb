require 'test_helper'

class TicketsControllerTest < ActionController::TestCase

  def setup
    @topic = topics(:os)
    @t = tickets(:ticket1)
    @nontech = employees(:nontech)
    @tech = employees(:tech)
    @e = employees(:mallison)
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

    get :edit, id: @t
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :update, id: @t
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    put :update, id: @t
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    %i(my assigned_to_me).each do |action|
      get action, status: action
      assert_redirected_to login_path
      assert_equal 'Please sign in.', flash[:danger]
    end

    %w(all open unassigned work_in_progress hold on_hold closed).each do |status|
      get :index, status: status
      assert_redirected_to login_path
      assert_equal 'Please sign in.', flash[:danger]
    end

    patch :assign_to_me, id: @t
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    get :show, id: @t
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]
  end

  test 'should allow non-technician rights to access' do
    log_in(@nontech) # test/test_helper.rb

    get :my, status: 'my'
    assert_response :success

    get :new
    assert_response :success

    post :create, ticket: { creator: @nontech }
    assert_response :success

    get :edit, id: @t
    assert_response :success

    patch :update, id: @t, ticket: { description: 'Test' }
    assert_redirected_to ticket_path

    put :update, id: @t, ticket: { description: 'Test' }
    assert_redirected_to ticket_path
  end

  test 'should require technician rights to access' do
    log_in(@nontech) # test/test_helper.rb

  end

  test 'should restrict to current employee or technician' do
    log_in(@nontech) # test/test_helper.rb

    # assert_redirected_to my_tickets_path
    # assert_equal 'You are not authorized to view that ticket!', flash[:danger]
  end

end
