require 'test_helper'

class NonTechViewsTest < ActionDispatch::IntegrationTest
  def setup
    @active_nontech = employees(:active_nontech)
    integration_login(@active_nontech)
  end

  def teardown
    logout!
  end

  test '/employees/:id/edit DOES NOT show field: Account Status' do
    visit "/employees/#{@active_nontech.username}/edit"
    assert page.has_no_css?('label', text: /Account Status/)
    assert page.has_no_field?('employee_active_0', type: 'radio')
    assert page.has_no_field?('employee_active_1', type: 'radio')
  end

  test '/employees/:id/edit DOES NOT show field: User Rights' do
    visit "/employees/#{@active_nontech.username}/edit"
    assert page.has_no_css?('label', text: /User Rights/)
    assert page.has_no_field?('employee_technician_0', type: 'radio')
    assert page.has_no_field?('employee_technician_1', type: 'radio')
  end

  test '/tickets/new DOES NOT show field: Select Status' do
    visit "/tickets/new"
    assert page.has_no_css?('label', text: /Select Status/)
    assert page.has_no_select?('ticket_status')
  end

  test '/tickets/new DOES NOT show field: Assigned To' do
    visit "/tickets/new"
    assert page.has_no_css?('label', text: /Assigned To/)
    assert page.has_no_select?('ticket_technician_id')
  end
end
