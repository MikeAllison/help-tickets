class RenameAdminOnEmployees < ActiveRecord::Migration
  def change
    rename_column :employees, :admin, :technician
  end
end
