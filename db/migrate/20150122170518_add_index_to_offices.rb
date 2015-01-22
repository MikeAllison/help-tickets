class AddIndexToOffices < ActiveRecord::Migration
  def change
    add_index :offices, :hidden
    add_index :offices, :active
  end
end
