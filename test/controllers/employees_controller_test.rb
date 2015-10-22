require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase

  def setup
    @active_tech = employees(:active_tech)
    @inactive_tech = employees(:inactive_tech)
    @active_nontech = employees(:active_nontech)
    @active_nontech_2 = employees(:active_nontech_2)
    @inactive_nontech = employees(:inactive_nontech)
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

    get :edit, id: @active_nontech.username
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :update, id: @active_nontech.username
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    put :update, id: @active_nontech.username
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]

    patch :hide, id: @active_nontech.username
    assert_redirected_to login_path
    assert_equal 'Please sign in.', flash[:danger]
  end

  test 'should require technician rights to access' do
    log_in(@active_nontech) # test/test_helper.rb

    %i(index new).each do |action|
      get action
      assert_redirected_to my_tickets_path
      assert_equal 'That action requires technician rights!', flash[:danger]
    end

    post :create
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]

    patch :hide, id: @active_nontech.username
    assert_redirected_to my_tickets_path
    assert_equal 'That action requires technician rights!', flash[:danger]
  end

  test 'technicians can create employees' do
    log_in(@active_tech)
    assert_difference('Employee.count') do
      post :create, employee: { fname: 'Employee', lname: 'One', password: 'asdfsadf', password_confirmation:'asdfsadf', office_id: offices(:maitland).id, active: true, technician: true }
      assert_redirected_to new_employee_path
      assert_equal 'Employee added!', flash[:success]
    end
  end

  ### MOVE TESTS BELOW TO INTEGRATION TESTS ###

  test 'non-technicians cannot make themself a technician' do
    log_in(@active_nontech)
    patch :update, id: @active_nontech, employee: { technician: true }
    assert_redirected_to my_tickets_path
    # employee_params_restricted causes a silent failure (CHANGE)  
    @active_nontech.reload
    assert_not @active_nontech.technician, 'Non-technicians can change their technician status to true'
  end

  test 'non-technicians cannot make others a technician' do
    log_in(@active_nontech)
    patch :update, id: @active_nontech_2, employee: { technician: true }
    # employee_params_restricted causes a silent failure (CHANGE)
    @active_nontech_2.reload
    assert_not @active_nontech_2.technician, 'Non-technicians can make others a technician'
    assert_redirected_to edit_employee_path(@active_nontech)
  end

  test 'technicians can change others technician field' do
    log_in(@active_tech)
    patch :update, id: @active_nontech, employee: { technician: true }
    assert_equal 'Employee profile updated!', flash[:success]
    @active_nontech.reload
    assert @active_nontech.technician, 'Technicians cannot change others technician status'
    assert_redirected_to new_employee_path
  end

  test 'non-technicians cannot change their active status' do
    log_in(@active_nontech)
    patch :update, id: @active_nontech, employee: { active: false }
    assert_redirected_to my_tickets_path
    # employee_params_restricted causes a silent failure (CHANGE)
    @active_nontech.reload
    assert @active_nontech.active, 'Non-technicians can change their active status'
  end

  test 'non-technicians cannot change others active status' do
    log_in(@active_nontech)
    patch :update, id: @active_nontech_2, employee: { active: false }
    # employee_params_restricted causes a silent failure (CHANGE)
    @active_nontech_2.reload
    assert @active_nontech_2.active, 'Non-technicians can change others active status'
    assert_redirected_to edit_employee_path(@active_nontech)
  end

  test 'technicians can change others active field' do
    log_in(@active_tech)
    patch :update, id: @inactive_nontech, employee: { active: true }
    assert_equal 'Employee profile updated!', flash[:success]
    @inactive_nontech.reload
    assert @inactive_nontech.active, 'Technicians cannot change others active status'
    assert_redirected_to new_employee_path
  end

  test 'non-techs SHOULD NOT be able to edit other profiles' do
    log_in(@active_nontech)
    get :edit, id: @active_tech
    assert_redirected_to edit_employee_path(@active_nontech)
    assert_equal "You are not authorized to edit that employee's profile!", flash[:danger]
  end

  test 'techs should be able to edit other profiles' do
    log_in(@active_tech)
    get :edit, id: @active_nontech
    assert_response :success
  end

  test 'non-techs SHOULD NOT be able to update other profiles' do
    log_in(@active_nontech)
    patch :update, id: @active_tech, employee: { fname: 'Test' }
    assert_equal "You are not authorized to edit that employee's profile!", flash[:danger]
    @active_tech.reload
    assert_redirected_to edit_employee_path(@active_nontech)
    assert_equal 'Active', @active_tech.fname
  end

  test 'techs should be able to update other profiles' do
    log_in(@active_tech)
    patch :update, id: @active_nontech, employee: { fname: 'Test' }
    assert_equal 'Employee profile updated!', flash[:success]
    @active_nontech.reload
    assert_redirected_to new_employee_path
    assert_equal 'Test', @active_nontech.fname
  end

end
