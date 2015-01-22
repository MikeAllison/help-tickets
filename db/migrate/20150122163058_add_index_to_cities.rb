class AddIndexToCities < ActiveRecord::Migration
  def change
    add_index :cities, :hidden
  end
end
