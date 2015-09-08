require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  def setup
    @e = employees(:mallison)
  end

  test 'should not save without a first_name' do
    assert_not_blank(@e, :first_name)
  end

  test 'should not save without a last_name' do
    assert_not_blank(@e, :last_name)
  end

  test 'should not save without an office_id' do
    assert_not_blank(@e, :office_id)
  end

  test 'should not save without a password on create' do
    employee = Employee.new(first_name: 'Mike', last_name: 'Allison', office_id: 1)
    assert_not employee.save
  end

  test 'should strip whitespace in first_name' do
    should_strip_whitespace(@e, :first_name)
  end

  test 'should strip whitespace in last_name' do
    should_strip_whitespace(@e, :last_name)
  end

  test 'should allow save without password on update' do
    @e.first_name = 'Michael'
    @e.password_digest = nil
    assert @e.save
  end

  test 'should create user_name before_create' do
    employee = Employee.create(first_name: 'Mike', last_name: 'Allison', password: 'asdfasdf', office_id: 1)
    assert_equal 'mallison', employee.user_name
  end

  test 'should auto-increment user_name' do
    employee1 = Employee.create(first_name: 'Mike', last_name: 'Allison', password: 'asdfasdf', office_id: 1)
    employee2 = Employee.create(first_name: 'Matthew', last_name: 'Allison', password: 'asdfasdf', office_id: 2)
    assert_equal 'mallison1', employee2.user_name
  end

  test 'testing last_first' do
    assert_equal 'Allison, Mike', employees(:mallison).last_first
  end

  test 'testing first_last' do
    assert_equal 'Mike Allison', employees(:mallison).first_last
  end

  test 'set_user_name should strip whitespace' do
    employee = Employee.create(first_name:  '  Jennifer  ', last_name: '  Van Allen  ', password: 'asdfasdf', office_id: 1)
    assert_equal 'jvanallen', employee.user_name
  end

  test 'should close tickets after employee is hidden' do
    ticket = Ticket.create(creator_id: @e.id, description: 'Words', topic_id: 1)
    ticket2 = Ticket.create(creator_id: @e.id, description: 'Words 2', topic_id: 2)
    @e.hide
    assert_equal true, @e.hidden
    assert_equal true, ticket.reload.closed?
    assert_equal true, ticket2.reload.closed?
  end

end
