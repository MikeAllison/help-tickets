require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase

  def setup
    @e = employees(:jvanallen)
    @inactive = employees(:inactive)
    @tech = employees(:tech)
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

    get :edit, id: @e.user_name
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :update, id: @e.user_name
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    put :update, id: @e.user_name
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :hide, id: @e.user_name
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

    patch :hide, id: @e.user_name
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]
  end

  ### MOVE TESTS BELOW TO INTEGRATION TESTS ###

  test 'restrict changes to technician field for non-technicians' do
    log_in(@nontech)
    patch :update, id: @nontech, employee: { technician: true }
    @nontech.save
    @nontech.reload
    assert_not @nontech.technician, 'Non-technicians can change their technician status to true'
    assert_redirected_to my_tickets_path
  end

  test 'technicians can change technician field' do
    log_in(@tech)
    patch :update, id: @nontech, employee: { technician: true }
    @nontech.save
    @nontech.reload
    assert @nontech.technician, 'Technicians cannot change employee technician status'
    assert_redirected_to new_employee_path
  end

  test 'restrict changes to active field for non-technicians' do
    log_in(@nontech)
    patch :update, id: @inactive, employee: { active: true }
    @inactive.save
    @inactive.reload
    assert_not @inactive.active, 'Non-technicians can change their active status to true'
    assert_redirected_to my_tickets_path
  end

  test 'technicians can change active field' do
    log_in(@tech)
    patch :update, id: @inactive, employee: { active: true }
    @inactive.save
    @inactive.reload
    assert @inactive.active, 'Technicians cannot change employee active status'
    assert_redirected_to new_employee_path
  end

end
