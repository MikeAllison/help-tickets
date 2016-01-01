class AddUrgencyToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :urgency, :integer, default: 0
  end
end
