# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Employee.create([
	{last_name: 'Van Allen', first_name: 'Jennifer', user_name: 'jvanallen', password: 'passwordj', password_confirmation: 'passwordj', office_id: 1, admin: false},
	{last_name: 'Souza', first_name: 'Carlos', user_name: 'csouza', password: 'passwordc', password_confirmation: 'passwordc', office_id: 2, admin: false},
	{last_name: 'Peyatt', first_name: 'Justin', user_name: 'jpeyatt', password: 'passwordj', password_confirmation: 'passwordj', office_id: 1, admin: false},
	{last_name: 'Kokkinos', first_name: 'Chris', user_name: 'ckokkinos', password: 'passwordc', password_confirmation: 'passwordc', office_id: 3, admin: false},
	{last_name: 'Soto', first_name: 'Eddie', user_name: 'esoto', password: 'passworde', password_confirmation: 'passworde', office_id: 2, admin: false},
	{last_name: 'Reid', first_name: 'Bonnie', user_name: 'breid', password: 'passwordb', password_confirmation: 'passwordb', office_id: 3, admin: false},
	{last_name: 'Fox', first_name: 'Michelle', user_name: 'mfox', password: 'passwordm', password_confirmation: 'passwordm', office_id: 1, admin: false},
	{last_name: 'Allison', first_name: 'Mike', user_name: 'mallison', password: 'passwordm', password_confirmation: 'passwordm', office_id: 1, admin: true}
])

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

Ticket.create([
  {description: 'Mouse not working', employee_id: '1', topic_id: '3'},
  {description: 'Keyboard not working', employee_id: '2', topic_id: '3'},
  {description: 'Monitor not working', employee_id: '3', topic_id: '2'},
  {description: 'Outlook not working', employee_id: '1', topic_id: '8'},
  {description: 'Install IE11', employee_id: '4', topic_id: '10'}
])
