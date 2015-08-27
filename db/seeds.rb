# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

City.create([
  {name: 'Orlando', state_id: 10},
  {name: 'San Francisco', state_id: 5},
  {name: 'Austin', state_id: 45}
])

Office.create([
  {name: 'Downtown Orlando', city_id: 1},
  {name: 'Metrowest', city_id: 1},
  {name: 'Fisherman\'s Wharf', city_id: 2},
  {name: 'Central Austin', city_id: 3}
])

Topic.create([
  {name: 'Misc'},
  {name: 'Computer'},
  {name: 'Monitor'},
  {name: 'Mouse/Keyboard'},
  {name: 'Docking Station'},
  {name: 'Telephone'},
  {name: 'Other Peripheral'},
  {name: 'Operating name'},
  {name: 'Outlook'},
  {name: 'Office'},
  {name: 'Browser'}
])

# Create standard user account
Employee.create(last_name: 'Van Allen',
                first_name: 'Jennifer',
                password: 'asdfasdf',
                password_confirmation: 'asdfasdf',
                office_id: 1,
                active: true,
                technician: false)

# Create 4 specfic technician accounts
Employee.create([
  {
    last_name: 'Allison',
    first_name: 'Mike',
    password: 'asdfasdf',
    password_confirmation: 'asdfasdf',
    office_id: 1,
    active: true,
    technician: true
  },{
    last_name: 'Peyatt',
    first_name: 'Justin',
    password: 'password',
    password_confirmation: 'password',
    office_id: 1,
    active: true,
    technician: true
  },{
    last_name: 'Souza',
    first_name: 'Carlos',
    password: 'password',
    password_confirmation: 'password',
    office_id: 1,
    active: true,
    technician: true
  }
])

# Create active technician users
3.times do |i|
  Employee.create(last_name: Faker::Name.last_name,
                  first_name: Faker::Name.first_name,
                  password: 'password',
                  password_confirmation: 'password',
                  office_id: rand(2..3),
                  active: true,
                  technician: true)
end

# Create inactive technician users
3.times do |i|
  Employee.create(last_name: Faker::Name.last_name,
                  first_name: Faker::Name.first_name,
                  password: 'password',
                  password_confirmation: 'password',
                  office_id: rand(2..3),
                  active: false,
                  technician: true)
end

# Create active employees
500.times do
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name

  Employee.create(last_name: last_name,
                  first_name: first_name,
                  password: 'password',
                  password_confirmation: 'password',
                  office_id: rand(1..4),
                  active: true,
                  technician: false)
end

# Create inactive employees
100.times do
  last_name = Faker::Name.last_name
  first_name = Faker::Name.first_name

  Employee.create(last_name: last_name,
                  first_name: first_name,
                  password: 'password',
                  password_confirmation: 'password',
                  office_id: rand(1..4),
                  active: false,
                  technician: false)
end

# Create a bunch of tickets for mallison
100.times do
  time = Faker::Time.between(7.days.ago, 5.days.ago)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                creator_id: 1,
                topic_id: rand(1..10),
                status: rand(1..3),
                created_at: time,
                updated_at: time + 1.day,
                technician_id: rand(2..11))
end

# Create unassigned tickets
100.times do
  time = Faker::Time.between(7.days.ago, 5.days.ago)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                creator_id: rand(1..600),
                topic_id: rand(1..10),
                status: 0,
                created_at: time,
                updated_at: time)
end

# Create assigned tickets
900.times do
  time = Faker::Time.between(7.days.ago, 5.days.ago)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                creator_id: rand(1..600),
                topic_id: rand(1..10),
                status: rand(1..3),
                created_at: time,
                updated_at: time + 2.days,
                technician_id: rand(2..11))
end

# Create comments on tickets
1500.times do
  time = Faker::Time.between(4.days.ago, 3.days.ago)

  Comment.create(body: Faker::Hacker.say_something_smart,
                 employee_id: rand(2..11),
                 ticket_id: rand(1..1000),
                 created_at: time,
                 updated_at: time)
end

# Set reopening comment on some tickets
100.times do |i|
  time = Faker::Time.between(2.days.ago, Time.now)

  Comment.create(body: Faker::Hacker.say_something_smart,
                 employee_id: rand(2..600),
                 ticket_id: i,
                 status_type: :reopening,
                 created_at: time,
                 updated_at: time)
end
