class AddHiddenToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :hidden, :boolean, default: false
  end
end
