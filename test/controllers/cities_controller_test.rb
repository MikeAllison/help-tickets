require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  def setup
    @c = cities(:miami)
    @hidden_city = cities(:hidden_city)
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
    functional_log_in(@active_nontech) # test/test_helper.rb

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

  test 'technicians can create cities' do
    functional_log_in(@active_tech)

    assert_difference('City.count') do
      post :create, city: { name: 'Springfield', state_id: states(:florida).id }
      assert_redirected_to new_city_path
      assert_equal 'City added!', flash[:success]
    end
  end

  test 'should not create a duplicate of a hidden city (case-sensitive)' do
    functional_log_in(@active_tech)

    assert_no_difference('City.count', 'A duplicate city was created') do
      post :create, city: { name: 'Hidden City', state_id: @hidden_city.state.id }
      assert_redirected_to new_city_path
      assert_equal 'This city had already existed but has now been unhidden!', flash[:success]
    end
  end

  test 'should not create a duplicate of a hidden city (case-insensitive)' do
    functional_log_in(@active_tech)

    assert_no_difference('City.count', 'A duplicate city was created') do
      post :create, city: { name: 'hidden city', state_id: @hidden_city.state.id }
      assert_redirected_to new_city_path
      assert_equal 'This city had already existed but has now been unhidden!', flash[:success]
    end
  end
end
