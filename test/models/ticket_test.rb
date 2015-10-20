require 'test_helper'

class TicketTest < ActiveSupport::TestCase

  def setup
    @t = tickets(:ticket1)
  end
  test 'test valid fixtures' do
    assert @t.valid?
  end

  test 'should not save without a originator:active_tech' do
    assert_not_blank(@t, :originator_id)
  end

  test 'should not save without a submitter:active_tech' do
    assert_not_blank(@t, :submitter_id)
  end

  test 'should not save without a topic_id' do
    assert_not_blank(@t, :topic_id)
  end

  test 'should not save without a description' do
    assert_not_blank(@t, :description)
  end

  test 'reopening a ticket as an employee' do
    @t.closed!
    @t.reload
    @t.reopen(employees(:active_nontech))
    @t.reload
    assert_equal 'unassigned', @t.status, 'ticket was not set to unassigned'
    assert_nil @t.technician, 'technician_id was not set to nil'
  end

  test 'reopening a ticket as a technician' do
    @t.closed!
    @t.reload
    @t.reopen(employees(:active_tech))
    @t.reload
    assert_equal 'work_in_progress', @t.status, 'ticket was not set to work_in_progress'
    assert_equal employees(:active_tech), @t.technician, 'ticket was not assigned to the tech that reopened it'
  end

  test 'closing a ticket as an employee' do
    technician = @t.technician
    @t.close(employees(:active_nontech))
    @t.reload
    assert @t.closed?, 'ticket was not set to closed'
    assert_equal technician, @t.technician, 'technician_id has changed'
  end

  test 'closing a ticket as a technician' do
    @t.close(employees(:active_tech))
    @t.reload
    assert @t.closed?, 'ticket was not set to closed'
    assert_equal employees(:active_tech), @t.technician, 'technician_id did not changed to the id of the closing tech'
  end

  test 'should set default status to 0 (unassigned)' do
    ticket = Ticket.create(originator: employees(:active_nontech), description: 'Testing', topic: topics(:os))
    assert_equal 'unassigned', ticket.status
  end

end
