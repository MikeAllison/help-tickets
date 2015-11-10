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

# Create 1 specfic technician account (Employee 2)
Employee.create(lname: 'Allison',
                fname: 'Mike',
                password: 'asdfasdf',
                password_confirmation: 'asdfasdf',
                office_id: 1,
                active: true,
                technician: true)

# Create active technicians (Employees 3-6)
4.times do |i|
  Employee.create(lname: Faker::Name.last_name,
                  fname: Faker::Name.first_name,
                  password: 'password',
                  password_confirmation: 'password',
                  office_id: rand(2..3),
                  active: true,
                  technician: true)
end

# Create inactive technicians (Employees 7-10)
4.times do |i|
  Employee.create(lname: Faker::Name.last_name,
                  fname: Faker::Name.first_name,
                  password: 'password',
                  password_confirmation: 'password',
                  office_id: rand(2..3),
                  active: false,
                  technician: true)
end

# Create standard user account (Employee 11)
Employee.create(lname: 'Van Allen',
                fname: 'Jennifer',
                password: 'asdfasdf',
                password_confirmation: 'asdfasdf',
                office_id: 1,
                active: true,
                technician: false)

# Create active employees (Employees 12-500)
489.times do
  lname = Faker::Name.last_name
  fname = Faker::Name.first_name

  Employee.create(lname: lname,
                  fname: fname,
                  password: 'password',
                  password_confirmation: 'password',
                  office_id: rand(1..4),
                  active: true,
                  technician: false)
end

# Create inactive employees (Employees 501-600)
100.times do
  lname = Faker::Name.last_name
  fname = Faker::Name.first_name

  Employee.create(lname: lname,
                  fname: fname,
                  password: 'password',
                  password_confirmation: 'password',
                  office_id: rand(1..4),
                  active: false,
                  technician: false)
end

# Create unassigned tickets for active employees (Tickets 1-200)
200.times do
  time = Faker::Time.between(3.days.ago, 1.days.ago) + rand(-10000..10000)
  originator_submitter = rand(12..500)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                originator_id: originator_submitter,
                submitter_id: originator_submitter,
                topic_id: rand(1..10),
                status: :unassigned,
                created_at: time,
                updated_at: time)
end

# Create WIP tickets for active employees (Tickets 201-400)
200.times do
  time = Faker::Time.between(6.days.ago, 4.days.ago) + rand(-10000..10000)
  originator_submitter = rand(12..500)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                originator_id: originator_submitter,
                submitter_id: originator_submitter,
                technician_id: rand(3..6),
                topic_id: rand(1..10),
                status: :work_in_progress,
                created_at: time,
                updated_at: time + rand(1..23).hours)
end

# Create tickets on hold for active employees (Tickets 401-600)
200.times do
  time = Faker::Time.between(8.days.ago, 7.days.ago) + rand(-10000..10000)
  originator_submitter = rand(12..500)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                originator_id: originator_submitter,
                submitter_id: originator_submitter,
                technician_id: rand(3..6),
                topic_id: rand(1..10),
                status: :on_hold,
                created_at: time,
                updated_at: time + rand(1..32).hours)
end

# Create closed tickets for active employees (Tickets 601-800)
200.times do
  time = Faker::Time.between(12.days.ago, 10.days.ago) + rand(-10000..10000)
  originator_submitter = rand(12..500)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                originator_id: originator_submitter,
                submitter_id: originator_submitter,
                technician_id: rand(3..6),
                topic_id: rand(1..10),
                status: :closed,
                created_at: time,
                updated_at: time + rand(1..32).hours)
end

# Create unassigned tickets for inactive employees (Tickets 801-825)
25.times do
  time = Faker::Time.between(3.days.ago, 1.days.ago) + rand(-10000..10000)
  originator_submitter = rand(501..600)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                originator_id: originator_submitter,
                submitter_id: originator_submitter,
                topic_id: rand(1..10),
                status: :unassigned,
                created_at: time,
                updated_at: time + rand(1..32).hours)
end

# Create assigned tickets for inactive employees (Tickets 826-875)
50.times do
  time = Faker::Time.between(6.days.ago, 4.days.ago) + rand(-10000..10000)
  originator_submitter = rand(501..600)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                originator_id: originator_submitter,
                submitter_id: originator_submitter,
                technician_id: rand(3..6),
                topic_id: rand(1..10),
                status: rand(1..2),
                created_at: time,
                updated_at: time + rand(1..32).hours)
end

# Create closed tickets for inactive employees (Tickets 876-900)
25.times do
  time = Faker::Time.between(9.days.ago, 7.days.ago) + rand(-10000..10000)
  originator_submitter = rand(501..600)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                originator_id: originator_submitter,
                submitter_id: originator_submitter,
                technician_id: rand(3..6),
                topic_id: rand(1..10),
                status: :closed,
                created_at: time,
                updated_at: time + rand(1..32).hours)
end

# Create unassigned tickets where the originator IS NOT the submitter (Tickets 901-950)
50.times do
  time = Faker::Time.between(3.days.ago, 1.days.ago)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                originator_id: rand(1..600),
                submitter_id: rand(1..600),
                topic_id: rand(1..10),
                status: :unassigned,
                created_at: time,
                updated_at: time)
end

# Create assigned tickets where the originator IS NOT the submitter (Tickets 951-1000)
50.times do
  time = Faker::Time.between(6.days.ago, 4.days.ago)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                originator_id: rand(1..600),
                submitter_id: rand(1..600),
                technician_id: rand(3..6),
                topic_id: rand(1..10),
                status: rand(1..3),
                created_at: time,
                updated_at: time + rand(1..32).hours)
end

# Create closed tickets that will be reopened (Tickets 1001-1100)
100.times do
  time = Faker::Time.between(9.days.ago, 7.days.ago) + rand(-10000..10000)
  originator_submitter = rand(12..600)

  Ticket.create(description: Faker::Hacker.say_something_smart,
                originator_id: originator_submitter,
                submitter_id: originator_submitter,
                technician_id: rand(3..6),
                topic_id: rand(1..10),
                status: :closed,
                created_at: time,
                updated_at: time + rand(1..32).hours)
end

# Create technician comments on closed tickets
closed_tickets = Ticket.where(status: :closed)

closed_tickets.each do |ticket|
  time = ticket.updated_at

  Comment.create(body: Faker::Hacker.say_something_smart,
                 employee_id: rand(3..10),
                 ticket_id: ticket.id,
                 status_type: :closing,
                 created_at: time,
                 updated_at: time)
end

# Set reopening comment on some closed tickets
reopened_tickets = Ticket.where(id: 1001..1100)

reopened_tickets.each do |ticket|
  time = ticket.updated_at + rand(1..12).hours

  ticket.unassigned!
  ticket.updated_at = time

  Comment.create(body: Faker::Hacker.say_something_smart,
                 employee_id: ticket.originator_id,
                 ticket_id: ticket.id,
                 status_type: :reopening,
                 created_at: time,
                 updated_at: time)
end
