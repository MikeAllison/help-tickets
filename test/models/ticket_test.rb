require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  def setup
    @ticket_new = tickets(:ticket_new)
    @ticket_unassigned = tickets(:ticket_unassigned)
    @ticket_hold = tickets(:ticket_hold)
    @ticket_wip = tickets(:ticket_wip)
    @ticket_closed = tickets(:ticket_closed)
    @active_nontech = employees(:active_nontech)
    @active_nontech_2 = employees(:active_nontech_2)
  end

  test 'test valid fixtures' do
    assert @ticket_unassigned.valid?
    assert @ticket_hold.valid?
    assert @ticket_wip.valid?
    assert @ticket_closed.valid?
    assert @active_nontech.valid?
    assert @active_nontech_2.valid?
  end

  test 'should not save without a originator_id' do
    assert_not_blank(@ticket_new, :originator_id)
  end

  test 'should not save without a submitter_id' do
    assert_not_blank(@ticket_new, :submitter_id)
  end

  test 'should not save without a topic_id' do
    assert_not_blank(@ticket_new, :topic_id)
  end

  test 'should not save without a description' do
    assert_not_blank(@ticket_new, :description)
  end

  test 'reopening a ticket as an employee' do
    @ticket_closed.reopen(employees(:active_nontech))
    @ticket_closed.reload
    assert_equal 'unassigned', @ticket_closed.status, 'ticket was not set to unassigned'
    assert_nil @ticket_closed.technician, 'technician_id was not set to nil'
  end

  test 'reopening a ticket as a technician' do
    @ticket_closed.reopen(employees(:active_tech))
    @ticket_closed.reload
    assert_equal 'work_in_progress', @ticket_closed.status, 'ticket was not set to work_in_progress'
    assert_equal employees(:active_tech), @ticket_closed.technician, 'ticket was not assigned to the tech that reopened it'
  end

  test 'closing a ticket as an employee' do
    @ticket_hold.close(employees(:active_nontech))
    @ticket_hold.reload
    assert @ticket_hold.closed?, 'ticket was not set to closed'
    assert_equal employees(:active_tech), @ticket_hold.technician, 'technician_id has changed'
  end

  test 'closing a ticket as a technician' do
    @ticket_wip.close(employees(:active_tech))
    @ticket_wip.reload
    assert @ticket_wip.closed?, 'ticket was not set to closed'
    assert_equal employees(:active_tech), @ticket_wip.technician, 'technician_id did not changed to the id of the closing tech'
  end

  test 'should set a submitter_id when created' do
    current_employee = @active_nontech
    ticket = Ticket.new(originator: employees(:active_nontech), description: 'Testing', topic: topics(:os))
    ticket.save
    ticket.reload
    assert_equal @active_nontech, ticket.submitter
  end

  test 'should set default status to 0 (unassigned)' do
    ticket = Ticket.create(originator: employees(:active_nontech), description: 'Testing', topic: topics(:os))
    assert_equal 'unassigned', ticket.status
  end

end
