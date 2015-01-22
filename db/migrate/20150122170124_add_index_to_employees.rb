class AddIndexToEmployees < ActiveRecord::Migration
  def change
    add_index :employees, :office_id
    add_index :employees, :active
    add_index :employees, :hidden
  end
end