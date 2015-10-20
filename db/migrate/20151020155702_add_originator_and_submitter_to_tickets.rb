class AddOriginatorAndSubmitterToTickets < ActiveRecord::Migration
  def change
    change_table :tickets do |t|
      t.rename :creator:active_tech, :originator_id
    end

    add_column :tickets, :submitter_id, :integer, index: true
  end
end
