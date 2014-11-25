class AddActiveToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :active, :boolean, default: false
  end
end
