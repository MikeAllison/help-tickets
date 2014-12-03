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
                password: 'password', 
                password_confirmation: 'password', 
                office_id: 1,
                active: true, 
                admin: true)

# Create active admin users (admin1-6)
6.times do |i|
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  user_name = 'admin' + i.to_s
  office_id = rand(1..3)
  
  Employee.create(last_name: last_name, 
                  first_name: first_name, 
                  user_name: user_name, 
                  password: 'password', 
                  password_confirmation: 'password', 
                  office_id: office_id,
                  active: true,
                  admin: true)
end

# Create inactive admin users (admin 7-9)
3.times do |i|
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  user_name = 'admin' + (i + 3).to_s
  office_id = rand(1..3)
  
  Employee.create(last_name: last_name, 
                  first_name: first_name, 
                  user_name: user_name, 
                  password: 'password', 
                  password_confirmation: 'password', 
                  office_id: office_id,
                  active: false, 
                  admin: true)
end

Employee.create(last_name: 'Van Allen', 
                first_name: 'Pooks', 
                user_name: 'pooks', 
                password: 'password', 
                password_confirmation: 'password', 
                office_id: 1,
                active: true, 
                admin: false)

# Create active employees
500.times do
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  user_name = first_name.slice(0) + last_name + rand(1..99).to_s
  office_id = rand(1..4)
  
  Employee.create(last_name: last_name, 
                  first_name: first_name, 
                  user_name: user_name, 
                  password: 'password', 
                  password_confirmation: 'password', 
                  office_id: office_id,
                  active: true,
                  admin: false)
end

# Create inactive employees
100.times do
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name
  user_name = first_name.slice(0) + last_name + rand(1..99).to_s
  office_id = rand(1..4)
  
  Employee.create(last_name: last_name, 
                  first_name: first_name, 
                  user_name: user_name, 
                  password: 'password', 
                  password_confirmation: 'password', 
                  office_id: office_id,
                  active: false,
                  admin: false)
end

Topic.create([
  {system: 'Misc'},
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
	{name: 'Downtown Orlando', city_id: 1},
	{name: 'Metrowest', city_id: 1},
	{name: 'Fisherman\'s Wharf', city_id: 2},
	{name: 'Central Austin', city_id: 3}
])

City.create([
  {name: 'Orlando', state_id: 10},
  {name: 'San Francisco', state_id: 5},
  {name: 'Austin', state_id: 45}
])

State.create([
  {name: 'Alabama', abbreviation: 'AL'},
  {name: 'Alaska', abbreviation: 'AK'},
  {name: 'Arizona', abbreviation: 'AZ'},
  {name: 'Arkansas', abbreviation: 'AR'},
  {name: 'California', abbreviation: 'CA'},
  {name: 'Colorado', abbreviation: 'CO'},
  {name: 'Connecticut', abbreviation: 'CT'},
  {name: 'Delaware', abbreviation: 'DE'},
  {name: 'District of Columbia', abbreviation: 'DC'},
  {name: 'Florida', abbreviation: 'FL'},
  {name: 'Georgia', abbreviation: 'GA'},
  {name: 'Hawaii', abbreviation: 'HI'},
  {name: 'Idaho', abbreviation: 'ID'},
  {name: 'Illinois', abbreviation: 'IL'},
  {name: 'Indiana', abbreviation: 'IN'},
  {name: 'Iowa', abbreviation: 'IA'},
  {name: 'Kansas', abbreviation: 'KS'},
  {name: 'Kentucky', abbreviation: 'KY'},
  {name: 'Louisiana', abbreviation: 'LA'},
  {name: 'Maine', abbreviation: 'ME'},
  {name: 'Maryland', abbreviation: 'MD'},
  {name: 'Massachusetts', abbreviation: 'MA'},
  {name: 'Michigan', abbreviation: 'MI'},
  {name: 'Minnesota', abbreviation: 'MN'},
  {name: 'Mississippi', abbreviation: 'MS'},
  {name: 'Missouri', abbreviation: 'MO'},
  {name: 'Montana', abbreviation: 'MT'},
  {name: 'Nebraska', abbreviation: 'NE'},
  {name: 'Nevada', abbreviation: 'NV'},
  {name: 'New Hampshire', abbreviation: 'NH'},
  {name: 'New Jersey', abbreviation: 'NJ'},
  {name: 'New Mexico', abbreviation: 'NM'},
  {name: 'New York', abbreviation: 'NY'},
  {name: 'North Carolina', abbreviation: 'NC'},
  {name: 'North Dakota', abbreviation: 'ND'},
  {name: 'Ohio', abbreviation: 'OH'},
  {name: 'Oklahoma', abbreviation: 'OK'},
  {name: 'Oregon', abbreviation: 'OR'},
  {name: 'Pennsylvania', abbreviation: 'PA'},
  {name: 'Puerto Rico', abbreviation: 'PR'},
  {name: 'Rhode Island', abbreviation: 'RI'},
  {name: 'South Carolina', abbreviation: 'SC'},
  {name: 'South Dakota', abbreviation: 'SD'},
  {name: 'Tennessee', abbreviation: 'TN'},
  {name: 'Texas', abbreviation: 'TX'},
  {name: 'Utah', abbreviation: 'UT'},
  {name: 'Vermont', abbreviation: 'VT'},
  {name: 'Virginia', abbreviation: 'VA'},
  {name: 'Washington', abbreviation: 'WA'},
  {name: 'West Virginia', abbreviation: 'WV'},
  {name: 'Wisconsin', abbreviation: 'WI'},
  {name: 'Wyoming', abbreviation: 'WY'}
])

# Create tickets
1000.times do
  description = Faker::Hacker.say_something_smart
  employee_id = rand(1..600)
  topic_id = rand(1..10)
  status_id = rand(1..4)
  time = Faker::Time.between(7.days.ago, 5.days.ago)
  
  Ticket.create(description: description,
                employee_id: employee_id,
                topic_id: topic_id,
                status_id: status_id,
                created_at: time,
                updated_at: time)
end

# Create comments on tickets
1500.times do
  body = Faker::Hacker.say_something_smart
  employee_id = rand(1..10)
  ticket_id = rand(1..1000)
  time = Faker::Time.between(4.days.ago, 3.days.ago)
  
  Comment.create(body: body,
                 employee_id: employee_id,
                 ticket_id: ticket_id,
                 created_at: time,
                 updated_at: time)
end

# Set reopening comment on some tickets
100.times do |i|
  body = Faker::Hacker.say_something_smart
  employee_id = rand(1..10)
  ticket_id = i
  time = Faker::Time.between(2.days.ago, Time.now)
  
  Comment.create(body: body,
                 employee_id: employee_id,
                 ticket_id: ticket_id,
                 reopening_comment: true,
                 created_at: time,
                 updated_at: time)
end

Status.create([
  {state: 'Unassigned'},
  {state: 'Work in Progress'},
  {state: 'On Hold'},
  {state: 'Closed'}
])
