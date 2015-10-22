require 'test_helper'

class TicketsControllerTest < ActionController::TestCase

  def setup
    @topic = topics(:os)
    @t = tickets(:ticket1)
    @active_nontech = employees(:active_nontech)
    @active_nontech_2 = employees(:active_nontech_2)
    @active_tech = employees(:active_tech)
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

  test 'non-techs should be able to create a ticket for themself' do
    log_in(@active_nontech)
    assert_difference('Ticket.count') do
      post :create, ticket: { originator_id: @active_nontech.id, submitter_id: @active_nontech.id, topic_id: topics(:os).id, description: 'Broken.' }
    end
    assert_equal 'Ticket was successfully submitted!', flash[:success]
    t = Ticket.last
    assert_equal @active_nontech.username, t.originator.username
    assert_equal @active_nontech.username, t.submitter.username
  end

  test 'non-techs should be able to create on behalf of another person' do
    log_in(@active_nontech)
    assert_difference('Ticket.count') do
      post :create, ticket: { originator_id: @active_nontech_2.id, submitter_id: @active_nontech.id, topic_id: topics(:os).id, description: 'Broken.' }
    end
    assert_equal 'Ticket was successfully submitted!', flash[:success]
    t = Ticket.last
    assert_equal @active_nontech_2.username, t.originator.username
    assert_equal @active_nontech.username, t.submitter.username
  end

  test 'non-techs should be able to see their own tickets' do
    log_in(@active_nontech)
    get :my, status: :my
    assert_response :success
    assert_includes(assigns(:tickets), @t)
    get :show, id: @t.id
    assert_response :success
    assert_includes(assigns(:tickets), @t)
  end

  test 'non-techs SHOULD NOT be able to see others tickets' do
    log_in(@active_nontech_2)
    get :show, id: @t.id
    assert_redirected_to my_tickets_path
    assert_equal 'You are not authorized to view that ticket!', flash[:danger]
  end

  test 'non-techs SHOULD be able to edit their own tickets' do
    log_in(@active_nontech)
    get :edit, id: @t.id
    assert_response :success
  end

  test 'non-techs SHOULD be able to update their own tickets'
    log_in(@active_nontech)
    patch :update, id: @t.id, ticket: { description: 'Test' }
    assert_equal 'Ticket was successfully updated!', flash[:success]
    @t.reload
    assert_equal 'Test', @t.description
  end

  test 'non-techs SHOULD NOT be able to edit others tickets' do
    log_in(@active_nontech_2)
    get :edit, id: @t.id
    assert_redirected_to my_tickets_path
    assert_equal 'You are not authorized to view that ticket!', flash[:danger]
  end

  test 'non-techs SHOULD NOT be able to update others tickets'
    log_in(@active_nontech_2)
    patch :update, id: @t.id, ticket: { description: 'Test' }
    assert_redirected_to my_tickets_path
    assert_equal 'You are not authorized to view that ticket!', flash[:danger]
  end

  test 'non-techs should be able to close their own tickets' do

  end

  test 'non-techs SHOULD NOT be able to close their own tickets' do

  end

  test 'non-techs should be able to reopen their own closed tickets' do

  end

  test 'non-techs SHOULD NOT be able to reopen others closed tickets' do

  end

  test 'non-techs should be able to comment on their own tickets' do

  end

  test 'non-techs SHOULD NOT be able to comment on others tickets' do

  end

  test 'non-techs SHOULD NOT be able to access the assigned_to_me view' do

  end

  test 'techs should be able to access the assigned_to_me view' do

  end

  test 'non-techs SHOULD NOT be able to user assign_to_me' do

  end

  test 'non-techs SHOULD NOT be able to access any of the index views (Unassigned, Open, WIP, On Hold, Closed)' do

  end

  test 'techs should be able to see all tickets' do

  end

  test 'techs should be able to assign tickets to themself' do

  end

  test 'techs should be able to see their own tickets' do

  end


end
