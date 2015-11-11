require 'test_helper'

class OfficesControllerTest < ActionController::TestCase

  def setup
    @o = offices(:downtownsf)
    @hidden_office = offices(:hidden_office)
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

    get :edit, id: @o.slug
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :update, id: @o.slug
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    put :update, id: @o.slug
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :hide, id: @o.slug
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

    get :edit, id: @o.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    patch :update, id: @o.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    put :update, id: @o.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    patch :hide, id: @o.slug
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]
  end

  test 'technicians can create offices' do
    functional_log_in(@active_tech)

    assert_difference('Office.count') do
      post :create, office: { name: 'Downtown', city_id: cities(:orlando).id }
      assert_redirected_to new_office_path
      assert_equal 'Office added!', flash[:success]
    end
  end

  test 'should not create a duplicate of a hidden office (case-sensitive)' do
    functional_log_in(@active_tech)

    assert_no_difference('Office.count', 'A duplicate office was created') do
      post :create, office: { name: 'Hidden Office', city_id: @hidden_office.city.id }
      assert_redirected_to new_office_path
      assert_equal 'This office had already existed but has now been unhidden!', flash[:success]
    end
  end

  test 'should not create a duplicate of a hidden office (case-insensitive)' do
    functional_log_in(@active_tech)

    assert_difference('Office.count', 'A duplicate office was created') do
      post :create, office: { name: 'hidden office', city_id: @hidden_office.city.id }
      assert_redirected_to new_office_path
      assert_equal 'This office had already existed but has now been unhidden!', flash[:success]
    end
  end

end
