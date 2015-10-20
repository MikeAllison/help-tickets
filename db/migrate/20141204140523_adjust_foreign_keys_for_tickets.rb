class AdjustForeignKeysForTickets < ActiveRecord::Migration
  def change
    rename_column :tickets, :employee_id, :creator:active_tech
    add_column :tickets, :technician_id, :integer
  end
end
