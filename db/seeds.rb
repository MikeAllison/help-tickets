# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Employee.create(last_name: 'Allison', 
                first_name: 'Mike', 
                user_name: 'mallison', 
                password: 'password1', 
                password_confirmation: 'password1', 
                office_id: 1, 
                admin: true)

9.times do
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  user_name = Faker::Internet.user_name
  office_id = rand(1..3)
  
  Employee.create(last_name: last_name, 
                  first_name: first_name, 
                  user_name: user_name, 
                  password: 'password1', 
                  password_confirmation: 'password1', 
                  office_id: office_id, 
                  admin: true)
end

100.times do
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  user_name = Faker::Internet.user_name
  office_id = rand(1..3)
  
  Employee.create(last_name: last_name, 
                  first_name: first_name, 
                  user_name: user_name, 
                  password: 'password1', 
                  password_confirmation: 'password1', 
                  office_id: office_id, 
                  admin: false)
end

Topic.create([
	{system: 'Computer'},
	{system: 'Monitor'},
	{system: 'Mouse/Keyboard'},
	{system: 'Docking Station'},
	{system: 'Telephone'},
	{system: 'Other Peripheral'},
	{system: 'Operating System'},
	{system: 'Outlook'},
	{system: 'Office'},
	{system: 'Browser'}
])

Office.create([
	{name: 'Orlando'},
	{name: 'San Francisco'},
	{name: 'Austin'}
])

100.times do
  description = Faker::Hacker.say_something_smart
  employee_id = rand(1..100)
  topic_id = rand(1..10)
  status_id = rand(1..4)
  time = Faker::Time.between(7.days.ago, Time.now)
  
  Ticket.create(description: description,
                employee_id: employee_id,
                topic_id: topic_id,
                status_id: status_id,
                created_at: time,
                updated_at: time)
end

Status.create([
  {state: 'Unassigned'},
  {state: 'Work in Progress'},
  {state: 'On Hold'},
  {state: 'Closed'}
])
