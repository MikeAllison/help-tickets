class AddUserNameToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :user_name, :string
  end
end
