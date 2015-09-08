require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  test 'should not save without a first name' do
    employee = employees(:mallison)
    employee.first_name = ''
    assert_not employee.save
  end

  test 'should not save without a last name' do
    employee = employees(:mallison)
    employee.last_name = ''
    assert_not employee.save
  end

  test 'should not save without an office id' do
    employee = employees(:mallison)
    employee.office_id = nil
    assert_not employee.save
  end

  test 'should not save without a password on create' do
    employee = Employee.new(first_name: 'Mike', last_name: 'Allison', office_id: 1)
    assert_not employee.save
  end

  test 'should allow save without password on update' do
    employee = employees(:mallison)
    employee.first_name = 'Michael'
    employee.password_digest = nil
    assert employee.save
  end

  test 'should create user_name before_create' do
    employee = Employee.create(first_name: 'Mike', last_name: 'Allison', password: 'asdfasdf', office_id: 1)
    assert_equal 'mallison', employee.user_name
  end

  test 'should auto-increment user names' do
    employee = Employee.create(first_name: 'Mike', last_name: 'Allison', password: 'asdfasdf', office_id: 1)
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

  test 'hide' do
    employee = employees(:mallison)
    ticket = Ticket.create(creator_id: employee.id, description: 'Words', topic_id: 1)
    ticket2 = Ticket.create(creator_id: employee.id, description: 'Words 2', topic_id: 2)
    employee.hide
    assert_equal true, employee.hidden
    assert_equal true, ticket.reload.closed?
    assert_equal true, ticket2.reload.closed?
  end

end
