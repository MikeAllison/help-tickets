namespace :db do
  desc "Create admin user"
  task :create_admin => :environment do
    Employee.create(
      fname: 'Admin',
      lname: 'Admin',
      password: 'asdfasdf',
      password_confirmation: 'asdfasdf',
      office_id: 1,
      technician: true,
      active: true
    )

    e = Employee.find_by(username: 'aadmin')
    e.update_columns(username: 'admin')
  end
end
