class AddHiddenToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :hidden, :boolean, default: false
    add_column :offices, :active, :boolean, default: true
  end
end
