class RemoveStatusTable < ActiveRecord::Migration
  def change
    remove_index :tickets, :status_id
    drop_table :statuses
    remove_column :tickets, :status_id
  end
end
