require 'test_helper'

class TicketsControllerTest < ActionController::TestCase

  def setup
    @topic = topics(:os)
    @t = tickets(:ticket1)
    @active_nontech = employees(:nontech_active)
    @active_tech = employees(:tech_active)
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
    log_in(@active_tech)
    assert_difference('Ticket.count') do
      post :create, ticket: { employee_id: @active_tech.id, topic_id: topics(:os).id, description: 'Broken.' }
    end
  end

  test 'non-techs should be able to create on behalf of another person' do

  end

  test 'non-techs should be able to see their own tickets' do

  end

  test 'non-techs SHOULD NOT be able to see others tickets' do

  end

  test 'non-techs SHOULD be able to edit their own ticket' do

  end

  test 'non-techs SHOULD NOT be able to edit others tickets' do

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
