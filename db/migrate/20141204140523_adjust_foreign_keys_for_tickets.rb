class AdjustForeignKeysForTickets < ActiveRecord::Migration
  def change
    rename_column :tickets, :employee_id, :creator_id
    add_column :tickets, :technician_id, :integer
    add_index :tickets, :technician_id
  end
end
