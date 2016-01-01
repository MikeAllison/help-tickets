require 'test_helper'

class TicketCreationTest < ActionDispatch::IntegrationTest

  def setup
    @active_nontech = employees(:active_nontech)
    @active_tech = employees(:active_tech)
    @t = topics(:os)
  end

  test 'ticket orginator field defaults to logged in employee' do
    integration_login(@active_nontech)
    click_link 'Create Ticket'
    within('form') do
      originator_id = find('#ticket_originator_id').value
      assert_equal @active_nontech.id.to_s, originator_id
    end
    logout!
  end

  test 'non-tech ticket form should not have Select Status or Assigned To fields' do
    integration_login(@active_nontech)
    click_link 'Create Ticket'
    within('form') do
      assert has_no_text?(/Select Status/)
      assert has_no_select?('ticket_status')
      assert has_no_text?(/Assigned To/)
      assert has_no_select?('ticket_technician_id')
    end
    logout!
  end

  test 'tech ticket form should have Select Status or Assigned To fields' do
    integration_login(@active_tech)
    click_link 'Tickets'
    click_link 'Create Ticket'
    within('form') do
      assert has_text?(/Select Status/)
      assert has_select?('ticket_status')
      assert has_text?(/Assigned To/)
      assert has_select?('ticket_technician_id')
    end
    logout!
  end

  test 'non-techs can create a ticket for themself' do
    integration_login(@active_nontech)
    click_link 'Tickets'
    click_link 'Create Ticket'
    within('form') do
      select(@t.name, from: 'Select Topic')
      fill_in 'Describe the Problem', with: 'Testing'
      click_button 'Create Ticket'
    end
    assert page.has_css?('.alert', text: /Ticket was successfully submitted!/)
    logout!
  end

  test 'non-techs can create an urgent ticket' do
    integration_login(@active_nontech)
    click_link 'Create Ticket'
    within('form') do
      select(@t.name, from: 'Select Topic')
      select('Urgent', from: 'Urgency')
      fill_in 'Describe the Problem', with: 'Testing'
      click_button 'Create Ticket'
    end
    assert page.has_css?('.alert', text: /Ticket was successfully submitted!/)
    logout!
  end

  test 'techs can create an urgent ticket' do
    integration_login(@active_nontech)
    click_link 'Tickets'
    click_link 'Create Ticket'
    within('form') do
      select(@active_nontech.last_first, from: 'Select Employee')
      select(@t.name, from: 'Select Topic')
      select('Urgent', from: 'Urgency')
      fill_in 'Describe the Problem', with: 'Testing'
      click_button 'Create Ticket'
    end
    assert page.has_css?('.alert', text: /Ticket was successfully submitted!/)
    logout!
  end

end
