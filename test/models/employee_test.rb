require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  employee = Employee.new(first_name: 'Mike', last_name: 'Allison', office_id: 1, password: 'asdfasdf')

  test 'should not save without a first name' do
    employee.first_name = nil
    assert_not employee.save
  end

  test 'should not save without a last name' do
    employee.last_name = nil
    assert_not employee.save
  end

  test 'should not save without an office id' do
    employee.office_id = nil
    assert_not employee.save
  end

  test 'should not save without a password on create' do
    employee = Employee.new(first_name: 'Mike', last_name: 'Allison', office_id: 1)
    assert_not employee.save
  end

  test 'should allow save without password on update' do
    mike = Employee.first
    mike.first_name = 'Michael'
    mike.password_digest = nil
    assert mike.save
  end

  test 'should create user_name before_create' do
    employee.save
    assert_equal 'mallison', employee.user_name
  end

  test 'should auto-increment user names' do
    employee.save
    employee2 = Employee.new(first_name: 'Mike', last_name: 'Allison', office_id: 1, password: 'asdfasdf')
    employee2.save
    assert_equal 'mallison1', employee2.user_name
  end

  test 'testing last_first' do
    assert_equal 'Allison, Mike', employee.last_first
  end

  test 'testing first_last' do
    assert_equal 'Mike Allison', employee.first_last
  end

  # test 'hide' do
  #   employee.save
  #   ticket = Ticket.create(creator_id: employee.id, description: 'Words', topic_id: 1)
  #   employee.hide
  #   assert_equal false, ticket.closed?
  #   assert_equal true, employee.hidden
  #   ticket.save
  #   assert_equal true, ticket.closed?
  # end

end
