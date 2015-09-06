namespace :db do
  desc "Create admin user"
  task :create_admin => :environment do
    Employee.create(
      first_name: 'Admin',
      last_name: 'Admin',
      password: 'asdfasdf',
      password_confirmation: 'asdfasdf',
      office_id: 1,
      technician: true,
      active: true
    )

    e = Employee.find_by(user_name: 'aadmin')
    e.update_columns(user_name: 'admin')
  end
end
