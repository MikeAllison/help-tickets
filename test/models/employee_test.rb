require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  def setup
    @active_nontech = employees(:active_nontech)
    @active_nontech_2 = employees(:active_nontech_2)
    @inactive_nontech = employees(:inactive_nontech)
  end

  test 'test valid fixtures' do
    assert @active_nontech.valid?
  end

  test 'should not save without a fname' do
    assert_not_blank(@active_nontech, :fname)
  end

  test 'should not save without a lname' do
    assert_not_blank(@active_nontech, :lname)
  end

  test 'should not save without an office_id' do
    assert_not_blank(@active_nontech, :office_id)
  end

  test 'should not save without a password on create' do
    employee = Employee.new(fname: 'A', lname: 'User', office_id: 1)
    assert_not employee.save
  end

  test 'should allow save without password on update' do
    @active_nontech.fname = 'Test'
    @active_nontech.password_digest = nil
    assert @active_nontech.save
  end

  test 'should strip whitespace in fname' do
    should_strip_whitespace(@active_nontech, :fname)
  end

  test 'should strip whitespace in lname' do
    should_strip_whitespace(@active_nontech, :lname)
  end

  test 'last_first' do
    assert_equal 'Nontech, Active', @active_nontech.last_first
  end

  test 'first_last' do
    assert_equal 'Active Nontech', @active_nontech.first_last
  end

  test 'hide should close tickets after employee is hidden' do
    ticket1 = Ticket.create(originator: @active_nontech, submitter: @active_nontech, description: 'Words', topic_id: 1)
    ticket2 = Ticket.create(originator: @active_nontech, submitter: @active_nontech_2, description: 'Words 2', topic_id: 2)
    @active_nontech.hide
    @active_nontech.reload
    assert @active_nontech.hidden
    assert ticket1.reload.closed?
    assert ticket2.reload.closed?
  end

  test 'should create username before saving' do
    employee = Employee.create(fname: 'Another', lname: 'User', password: 'asdfasdf', office_id: 1)
    assert_equal 'auser', employee.username
  end

  test 'username should strip whitespace' do
    employee = Employee.create(fname:  '  First  ', lname: '  Last Name  ', password: 'asdfasdf', office_id: 1)
    assert_equal 'flastname', employee.username
  end

  test 'should auto-increment username' do
    employee1 = Employee.create(fname: 'A', lname: 'User', password: 'asdfasdf', office_id: 1)
    employee2 = Employee.create(fname: 'Another', lname: 'User', password: 'asdfasdf', office_id: 2)
    assert_equal 'auser1', employee2.username
  end

  test 'should not update username if it has not changed' do
    employee1 = Employee.create(fname: 'A', lname: 'User', password: 'asdfasdf', office_id: 1)
    employee2 = Employee.create(fname: 'Another', lname: 'User', password: 'asdfasdf', office_id: 2)
    employee2.active = true
    employee2.save
    employee2.reload
    assert_equal 'auser1', employee2.username
  end

  test 'should not update username if it will stay the same after fname change' do
    employee1 = Employee.create(fname: 'A', lname: 'User', password: 'asdfasdf', office_id: 1)
    employee1.fname = 'Another'
    employee1.save
    employee1.reload
    assert_equal 'auser', employee1.username
  end
end
