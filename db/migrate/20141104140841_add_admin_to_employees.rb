class AddAdminToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :admin, :boolean, default: false
    add_index :employees, :admin
  end
end
