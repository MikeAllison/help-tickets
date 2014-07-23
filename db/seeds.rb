# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Employee.create([
	{last_name: 'Van Allen', first_name: 'Jennifer', office_id: 1},
	{last_name: 'Souza', first_name: 'Carlos', office_id: 2},
	{last_name: 'Peyatt', first_name: 'Justin', office_id: 1},
	{last_name: 'Kokkinos', first_name: 'Chris', office_id: 3},
	{last_name: 'Soto', first_name: 'Eddie', office_id: 2},
	{last_name: 'Reid', first_name: 'Bonnie', office_id: 3},
	{last_name: 'Fox', first_name: 'Michelle', office_id: 1}
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