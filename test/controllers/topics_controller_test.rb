require 'test_helper'

class TopicsControllerTest < ActionController::TestCase

  def setup
    @t = topics(:office)
    @hidden_inactive = topics(:hidden_inactive)
    @active_nontech = employees(:active_nontech)
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

    get :edit, id: @t.slug
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :update, id: @t.slug
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    put :update, id: @t.slug
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :hide, id: @t.slug
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]
  end

  test 'should require technician rights to access' do
    functional_log_in(@active_nontech) # test/test_helper.rb

    %i(index new).each do |action|
      get action
      assert_redirected_to my_tickets_path
      assert_equal 'That action requires technician rights!', flash[:danger]
    end

    post :create
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    get :edit, id: @t.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    patch :update, id: @t.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    put :update, id: @t.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    patch :hide, id: @t.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]
  end

  test 'technicians can create topics' do
    functional_log_in(@active_tech)

    assert_difference('Topic.count') do
      post :create, topic: { name: 'Misc' }
      assert_redirected_to new_topic_path
      assert_equal 'Topic added!', flash[:success]
    end
  end

  test 'should not create a duplicate of a hidden topic (case-sensitive)' do
    functional_log_in(@active_tech)

    assert_no_difference('Topic.count', 'A duplicate topic was created') do
      post :create, topic: { name: 'Hidden Inactive' }
      assert_redirected_to new_topic_path
      assert_equal 'This topic had already existed but has now been unhidden!', flash[:success]
    end
  end

  test 'should not create a duplicate of a hidden topic (case-insensitive)' do
    functional_log_in(@active_tech)

    assert_no_difference('Topic.count', 'A duplicate topic was created') do
      post :create, topic: { name: 'hidden inactive' }
      assert_redirected_to new_topic_path
      assert_equal 'This topic had already existed but has now been unhidden!', flash[:success]
    end
  end

end
