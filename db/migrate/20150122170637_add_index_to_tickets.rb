class AddIndexToTickets < ActiveRecord::Migration
  def change
    add_index :tickets, :creator_id
    add_index :tickets, :topic_id
  end
end
