class AddStatusIdToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :status, index: true
  end
end
