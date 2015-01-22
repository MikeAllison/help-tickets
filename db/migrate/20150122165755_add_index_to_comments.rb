class AddIndexToComments < ActiveRecord::Migration
  def change
    add_index :comments, :ticket_id
    add_index :comments, :employee_id
  end
end
