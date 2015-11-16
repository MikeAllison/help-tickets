require 'test_helper'

class TechnicianActionsTest < ActionDispatch::IntegrationTest

  def setup
    @active_tech = employees(:active_tech)
    integration_login(@active_tech)
  end

  def teardown
    logout!
  end

  test 'techs can get to the all employees page' do
    click_link 'Employees'
    click_link 'All Employees'
    assert page.has_css?('h3', text: /All Employees/)
  end

  test 'techs can get to the active employees page' do
    click_link 'Employees'
    click_link 'Active Employees'
    assert page.has_css?('h3', text: /Active Employees/)
  end

  test 'techs can get to the inactive employees page' do
    click_link 'Employees'
    click_link 'Inactive Employees'
    assert page.has_css?('h3', text: /Inactive Employees/)
  end

  test 'techs can get to the technician employees page' do
    click_link 'Employees'
    click_link 'Technician Employees'
    assert page.has_css?('h3', text: /Technician Employees/)
  end

  test 'techs can get to the add employees page' do
    click_link 'Employees'
    click_link 'Add Employees'
    assert page.has_css?('h3', text: /Add Employees/)
  end

  test 'techs can add an employee' do
    click_link 'Employees'
    click_link 'Add Employees'
    within('#new_employee') do
      fill_in 'First Name', with: 'Mike'
      fill_in 'Last Name', with: 'Allison'
      fill_in 'Password', with: 'Pass1234'
      fill_in 'Password Confirmation', with: 'Pass1234'
      select 'Maitland - Orlando, FL', from: 'Office'
      choose 'employee_active_1'
      choose 'employee_technician_1'
      click_button 'Add Employee'
    end
    assert page.has_css?('.alert', text: /Employee added!/)
    assert page.has_css?('table', text: /mallison/)
  end

  test 'password and password confirmation need to match' do
    click_link 'Employees'
    click_link 'Add Employees'
    within('#new_employee') do
      fill_in 'First Name', with: 'Mike'
      fill_in 'Last Name', with: 'Allison'
      fill_in 'Password', with: 'Pass1234'
      fill_in 'Password Confirmation', with: 'NotTheSame'
      select 'Maitland - Orlando, FL', from: 'Office'
      choose 'employee_active_1'
      choose 'employee_technician_1'
      click_button 'Add Employee'
    end
    assert page.has_css?('.validation-errors', text: /Passwords must match!/)
  end

end
