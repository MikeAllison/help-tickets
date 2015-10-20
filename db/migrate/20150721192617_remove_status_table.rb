class RemoveStatusTable < ActiveRecord::Migration
  def change
    remove_index :tickets, :status:active_tech
    drop_table :statuses
    remove_column :tickets, :status:active_tech
  end
end
