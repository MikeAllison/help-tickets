require 'test_helper'

class TicketShowTest < ActionDispatch::IntegrationTest

  def setup
    @active_tech = employees(:active_tech)
    @active_nontech = employees(:active_nontech)
    @ticket_unassigned = tickets(:ticket_unassigned)
    @ticket_hold = tickets(:ticket_hold)
    @ticket_wip = tickets(:ticket_wip)
    @ticket_closed = tickets(:ticket_closed)
  end

  test 'ticket/:id/show view displays common fields for non-techs' do
    integration_login(@active_nontech)
    visit "/tickets/#{@ticket_unassigned.id}"
    assert page.has_css?('li', text: /Requested For:/)
    assert page.has_css?('li', text: /Topic:/)
    assert page.has_css?('li', text: /Status:/)
    assert page.has_css?('li', text: /Created:/)
    assert page.has_css?('li', text: /Updated:/)
    assert page.has_css?('p', text: /Assigned To:/)
    assert page.has_css?('p', text: /Description:/)
    logout!
  end

  test 'ticket/:id/show view displays common fields for techs' do
    integration_login(@active_tech)
    visit "/tickets/#{@ticket_unassigned.id}"
    assert page.has_css?('li', text: /Requested For:/)
    assert page.has_css?('li', text: /Topic:/)
    assert page.has_css?('li', text: /Status:/)
    assert page.has_css?('li', text: /Created:/)
    assert page.has_css?('li', text: /Updated:/)
    assert page.has_css?('p', text: /Assigned To:/)
    assert page.has_css?('p', text: /Description:/)
    logout!
  end

  test 'ticket duration field' do
    integration_login(@active_tech)

    visit "/tickets/#{@ticket_unassigned.id}"
    assert page.has_css?('li', text: /Open For:/)

    visit "/tickets/#{@ticket_wip.id}"
    assert page.has_css?('li', text: /Open For:/)

    visit "/tickets/#{@ticket_hold.id}"
    assert page.has_css?('li', text: /Open For:/)

    visit "/tickets/#{@ticket_closed.id}"
    assert page.has_css?('li', text: /Closed In:/)

    logout!
  end

  test 'non-techs have the correct buttons' do
    integration_login(@active_nontech)
    visit "/tickets/#{@ticket_unassigned.id}"
    assert page.has_no_css?('a', text: /Assign to Me/)
    assert page.has_css?('a', text: /Edit Ticket/)
    assert page.has_css?('button', text: /Close Ticket/)
    assert page.has_css?('button', text: /Cancel/)
    logout!
  end

  test 'techs have the correct buttons' do
    integration_login(@active_tech)
    visit "/tickets/#{@ticket_unassigned.id}"
    assert page.has_css?('a', text: /Assign to Me/)
    assert page.has_css?('a', text: /Edit Ticket/)
    assert page.has_css?('button', text: /Close Ticket/)
    assert page.has_css?('button', text: /Cancel/)
    logout!
  end

end
