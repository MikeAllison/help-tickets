require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase

  def setup
    @tech_active = employees(:tech_active)
    @tech_inactive = employees(:tech_inactive)
    @nontech_active = employees(:nontech_active)
    @nontech_inactive = employees(:nontech_inactive)
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

    get :edit, id: @nontech_active.username
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :update, id: @nontech_active.username
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    put :update, id: @nontech_active.username
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :hide, id: @nontech_active.username
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]
  end

  test 'should require technician rights to access' do
    log_in(@nontech_active) # test/test_helper.rb

    %i(index new).each do |action|
      get action
      assert_redirected_to my_tickets_path
      assert_equal 'That action requires technician rights!', flash[:danger]
    end

    post :create
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    patch :hide, id: @nontech_active.username
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]
  end

  ### MOVE TESTS BELOW TO INTEGRATION TESTS ###

  test 'restrict changes to technician field for non-technicians' do
    log_in(@nontech_active)
    patch :update, id: @nontech_active, employee: { technician: true }
    @nontech_active.save
    @nontech_active.reload
    assert_not @nontech_active.technician, 'Non-technicians can change their technician status to true'
    assert_redirected_to my_tickets_path
  end

  test 'technicians can change technician field' do
    log_in(@tech_active)
    patch :update, id: @nontech_active, employee: { technician: true }
    @nontech_active.save
    @nontech_active.reload
    assert @nontech_active.technician, 'Technicians cannot change employee technician status'
    assert_redirected_to new_employee_path
  end

  test 'non-technicians cannot change their active field' do
    log_in(@nontech_active)
    patch :update, id: @nontech_active, employee: { active: false }
    @nontech_active.save
    @nontech_active.reload
    assert @nontech_active.active, 'Non-technicians can change their active status'
    assert_redirected_to my_tickets_path
  end

  test 'technicians can change active field' do
    log_in(@tech_active)
    patch :update, id: @nontech_inactive, employee: { active: true }
    @nontech_inactive.save
    @nontech_inactive.reload
    assert @nontech_inactive.active, 'Technicians cannot change employee active status'
    assert_redirected_to new_employee_path
  end

  test 'non-techs SHOULD NOT be able to edit other profiles' do
    log_in(@nontech_active)
    get :edit, id: @tech_active
    assert_redirected_to edit_employee_path(@nontech_active)
    assert_equal "You are not authorized to edit that employee's profile!", flash[:danger]
  end

  test 'techs should be able to edit other profiles' do
    log_in(@tech_active)
    get :edit, id: @nontech_active
    assert_response :success
  end

  test 'non-techs SHOULD NOT be able to update other profiles' do
    log_in(@nontech_active)
    patch :update, id: @tech_active, employee: { fname: 'Test' }
    @tech_active.save
    @tech_active.reload
    assert_redirected_to edit_employee_path(@tech_active)
    assert_equal 'Active', @tech_active.fname
  end

  test 'techs should be able to update other profiles' do
    log_in(@tech_active)
    patch :update, id: @nontech_active, employee: { fname: 'Test' }
    @nontech_active.save
    @nontech_active.reload
    assert_redirected_to new_employee_path
    assert_equal 'Test', @nontech_active.fname
  end

end
