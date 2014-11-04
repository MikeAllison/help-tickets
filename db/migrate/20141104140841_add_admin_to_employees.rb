class AddAdminToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :admin, :boolean
    add_index :employees, :admin
  end
end
