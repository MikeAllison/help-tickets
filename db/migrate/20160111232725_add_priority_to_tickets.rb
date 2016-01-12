class AddPriorityToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :priority, :integer, default: 0
  end
end
