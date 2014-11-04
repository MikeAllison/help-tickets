class AddUserNameToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :user_name, :string
    add_index :employees, :user_name, unique: true
  end
end
