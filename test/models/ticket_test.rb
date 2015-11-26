require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  def setup
    @ticket_unassigned = tickets(:ticket_unassigned)
    @ticket_hold = tickets(:ticket_hold)
    @ticket_wip = tickets(:ticket_wip)
    @ticket_closed = tickets(:ticket_closed)
    @os = topics(:os)
  end

  test 'test valid fixtures' do
    assert @ticket_unassigned.valid?
    assert @ticket_hold.valid?
    assert @ticket_wip.valid?
    assert @ticket_closed.valid?
  end

  test 'should not save without a originator_id' do
    assert_not_blank(@ticket_unassigned, :originator_id)
  end

  test 'should not save without a submitter_id' do
    assert_not_blank(@ticket_unassigned, :submitter_id)
  end

  test 'should not save without a topic_id' do
    assert_not_blank(@ticket_unassigned, :topic_id)
  end

  test 'should not save without a description' do
    assert_not_blank(@ticket_unassigned, :description)
  end

  test 'reopening a ticket as an employee' do
    @ticket_closed.reopen(employees(:active_nontech))
    @ticket_closed.reload
    assert_equal 'unassigned', @ticket_closed.status, 'ticket was not set to unassigned'
    assert_nil @ticket_closed.closed_at, 'closed_at was not set to nil'
    assert_nil @ticket_closed.technician, 'technician_id was not set to nil'
  end

  test 'reopening a ticket as a technician' do
    @ticket_closed.reopen(employees(:active_tech))
    @ticket_closed.reload
    assert_equal 'work_in_progress', @ticket_closed.status, 'ticket was not set to work_in_progress'
    assert_nil @ticket_closed.closed_at, 'closed_at was not set to nil'
    assert_equal employees(:active_tech), @ticket_closed.technician, 'ticket was not assigned to the tech that reopened it'
  end

  test 'closing a ticket as an employee' do
    @ticket_hold.close(employees(:active_nontech))
    @ticket_hold.reload
    assert @ticket_hold.closed?, 'ticket was not set to closed'
    assert_not_nil @ticket_hold.closed_at, 'closed_at was not set'
    #assert_equal @ticket_hold.updated_at, @ticket_hold.closed_at, 'correct closed_at time was not set'
    assert_equal employees(:active_tech), @ticket_hold.technician, 'technician_id has changed'
  end

  test 'closing a ticket as a technician' do
    @ticket_wip.close(employees(:active_tech))
    @ticket_wip.reload
    assert @ticket_wip.closed?, 'ticket was not set to closed'
    assert_not_nil @ticket_wip.closed_at, 'closed_at was not set'
    assert_equal (@ticket_wip.updated_at).to_i, (@ticket_wip.closed_at).to_i, 'correct closed_at time was not set'
    assert_equal employees(:active_tech), @ticket_wip.technician, 'technician_id did not changed to the id of the closing tech'
  end

  test 'open? method works' do
    assert @ticket_unassigned.open?
    assert @ticket_wip.open?
    assert @ticket_hold.open?
    assert_not @ticket_closed.open?
  end

  test 'should set default status to 0 (unassigned)' do
    ticket = Ticket.create(originator: employees(:active_nontech), description: 'Testing', topic: topics(:os))
    assert_equal 'unassigned', ticket.status
  end

  test 'total_time_open for an open ticket' do
    current_time = Time.now
    time_in_past = current_time - 27.hours - 23.minutes
    total_time = current_time - time_in_past

    @ticket_hold.created_at = time_in_past

    assert_equal total_time, @ticket_hold.total_seconds_open_as_i
  end

  test 'total_time_open for a closed ticket' do
    current_time = Time.now
    time_in_past = current_time - 27.hours - 23.minutes
    time_created = time_in_past
    time_closed = time_in_past + 16.hours + 39.minutes
    total_time = time_closed - time_created

    @ticket_closed.created_at = time_created
    @ticket_closed.updated_at = time_closed
    @ticket_closed.closed_at = time_closed

    assert_equal total_time, @ticket_closed.total_seconds_open_as_i
  end

end
