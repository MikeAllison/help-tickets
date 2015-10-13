require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase

  def setup
    @active_tech = employees(:tech_active)
    @inactive_tech = employees(:tech_inactive)
    @active_nontech = employees(:nontech_active)
    @inactive_nontech = employees(:nontech_inactive)
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

  ### MOVE TESTS BELOW TO INTEGRATION TESTS ###

  test 'restrict changes to technician field for non-technicians' do
    log_in(@active_nontech)
    patch :update, id: @active_nontech, employee: { technician: true }
    @active_nontech.save
    @active_nontech.reload
    assert_not @active_nontech.technician, 'Non-technicians can change their technician status to true'
    assert_redirected_to my_tickets_path
  end

  test 'technicians can change technician field' do
    log_in(@active_tech)
    patch :update, id: @active_nontech, employee: { technician: true }
    @active_nontech.save
    @active_nontech.reload
    assert @active_nontech.technician, 'Technicians cannot change employee technician status'
    assert_redirected_to new_employee_path
  end

  test 'non-technicians cannot change their active field' do
    log_in(@active_nontech)
    patch :update, id: @active_nontech, employee: { active: false }
    @active_nontech.save
    @active_nontech.reload
    assert @active_nontech.active, 'Non-technicians can change their active status'
    assert_redirected_to my_tickets_path
  end

  test 'technicians can change active field' do
    log_in(@active_tech)
    patch :update, id: @inactive_nontech, employee: { active: true }
    @inactive_nontech.save
    @inactive_nontech.reload
    assert @inactive_nontech.active, 'Technicians cannot change employee active status'
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
    @active_tech.save
    @active_tech.reload
    assert_redirected_to edit_employee_path(@active_nontech)
    assert_equal 'Active', @active_tech.fname
  end

  test 'techs should be able to update other profiles' do
    log_in(@active_tech)
    patch :update, id: @active_nontech, employee: { fname: 'Test' }
    @active_nontech.save
    @active_nontech.reload
    assert_redirected_to new_employee_path
    assert_equal 'Test', @active_nontech.fname
  end

end
