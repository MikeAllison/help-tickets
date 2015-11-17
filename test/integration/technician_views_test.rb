require 'test_helper'

class TechnicianViewsTest < ActionDispatch::IntegrationTest

  def setup
    @active_tech = employees(:active_tech)
    @active_nontech = employees(:active_nontech)
    integration_login(@active_tech)
  end

  def teardown
    logout!
  end

  test 'employees/technicians shows field: Assigned To' do
    visit '/employees/technicians'
    assert page.has_css?('th', text: /Tickets Assigned/)
  end

  test 'employees/all does not show field: Assigned To' do
    visit '/employees/all'
    assert page.has_no_css?('th', text: /Tickets Assigned/)
  end

  test 'employees/active does not show field: Assigned To' do
    visit '/employees/active'
    assert page.has_no_css?('th', text: /Tickets Assigned/)
  end

  test 'employees/inactive does not show field: Assigned To' do
    visit '/employees/inactive'
    assert page.has_no_css?('th', text: /Tickets Assigned/)
  end

  test 'employees/:id/assigned_tickets does not show field: Assigned To' do
    visit "/employees/#{@active_tech.username}/assigned_tickets"
    assert page.has_no_css?('th', text: /Assigned To/)
  end

  test '/employees/:id/edit shows field: Account Status' do
    visit "/employees/#{@active_nontech.username}/edit"
    assert page.has_css?('label', text: /Account Status/)
    assert page.has_field?('employee_active_0', type: 'radio')
    assert page.has_field?('employee_active_1', type: 'radio')
  end

  test '/employees/:id/edit shows field: User Rights' do
    visit "/employees/#{@active_nontech.username}/edit"
    assert page.has_css?('label', text: /User Rights/)
    assert page.has_field?('employee_technician_0', type: 'radio')
    assert page.has_field?('employee_technician_1', type: 'radio')
  end

  test '/tickets/new shows field: Select Status' do
    visit "/tickets/new"
    assert page.has_css?('label', text: /Select Status/)
    assert page.has_select?('ticket_status')
  end

  test '/tickets/new shows field: Assigned To' do
    visit "/tickets/new"
    assert page.has_css?('label', text: /Assigned To/)
    assert page.has_select?('ticket_technician_id')
  end

end
