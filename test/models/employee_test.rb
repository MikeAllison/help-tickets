require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  def setup
    @nontech_active = employees(:nontech_active)
  end

  test 'test valid fixtures' do
    assert @nontech_active.valid?
  end

  test 'should not save without a first_name' do
    assert_not_blank(@nontech_active, :first_name)
  end

  test 'should not save without a last_name' do
    assert_not_blank(@nontech_active, :last_name)
  end

  test 'should not save without an office_id' do
    assert_not_blank(@nontech_active, :office_id)
  end

  test 'should not save without a password on create' do
    employee = Employee.new(first_name: 'A', last_name: 'User', office_id: 1)
    assert_not employee.save
  end

  test 'should allow save without password on update' do
    @nontech_active.first_name = 'Test'
    @nontech_active.password_digest = nil
    assert @nontech_active.save
  end

  test 'should strip whitespace in first_name' do
    should_strip_whitespace(@nontech_active, :first_name)
  end

  test 'should strip whitespace in last_name' do
    should_strip_whitespace(@nontech_active, :last_name)
  end

  test 'last_first' do
    assert_equal 'Nontech, Active', @nontech_active.last_first
  end

  test 'first_last' do
    assert_equal 'Active Nontech', @nontech_active.first_last
  end

  test 'hide should close tickets after employee is hidden' do
    ticket1 = Ticket.create(creator_id: @nontech_active.id, description: 'Words', topic_id: 1)
    ticket2 = Ticket.create(creator_id: @nontech_active.id, description: 'Words 2', topic_id: 2)
    @nontech_active.hide
    @nontech_active.reload
    assert @nontech_active.hidden
    assert ticket1.reload.closed?
    assert ticket2.reload.closed?
  end

  test 'should create user_name before saving' do
    employee = Employee.create(first_name: 'Another', last_name: 'User', password: 'asdfasdf', office_id: 1)
    assert_equal 'auser', employee.user_name
  end

  test 'should not update user_name if it has not changed' do
    @nontech_active.save
    @nontech_active.reload
    assert_equal 'anontech', @nontech_active.user_name
  end

  test 'set_user_name should strip whitespace' do
    employee = Employee.create(first_name:  '  First  ', last_name: '  Last Name  ', password: 'asdfasdf', office_id: 1)
    assert_equal 'flastname', employee.user_name
  end

  test 'should auto-increment user_name' do
    employee1 = Employee.create(first_name: 'A', last_name: 'User', password: 'asdfasdf', office_id: 1)
    employee2 = Employee.create(first_name: 'Another', last_name: 'User', password: 'asdfasdf', office_id: 2)
    assert_equal 'auser1', employee2.user_name
  end

end
