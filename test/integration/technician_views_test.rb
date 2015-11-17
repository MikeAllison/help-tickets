require 'test_helper'

class TechnicianViewsTest < ActionDispatch::IntegrationTest

  def setup
    @active_tech = employees(:active_tech)
    integration_login(@active_tech)
  end

  def teardown
    logout!
  end

  test 'tickets assigned field shows on employees/technicians' do
    click_link 'Employees'
    click_link 'Technician Employees'
    assert page.has_css?('table', text: /Tickets Assigned/)
  end

  test 'tickets assigned field does not show on employees/all' do
    click_link 'Employees'
    click_link 'All Employees'
    assert page.has_no_css?('table', text: /Tickets Assigned/)
  end

  test 'tickets assigned field does not show on employees/active' do
    click_link 'Employees'
    click_link 'Active Employees'
    assert page.has_no_css?('table', text: /Tickets Assigned/)
  end

  test 'tickets assigned field does not show on employees/inactive' do
    click_link 'Employees'
    click_link 'Inactive Employees'
    assert page.has_no_css?('table', text: /Tickets Assigned/)
  end

end
