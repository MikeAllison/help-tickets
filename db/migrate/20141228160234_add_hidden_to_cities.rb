class AddHiddenToCities < ActiveRecord::Migration
  def change
    add_column :cities, :hidden, :boolean, default: false
  end
end
