class AddIndexToTopics < ActiveRecord::Migration
  def change
    add_index :topics, :active
    add_index :topics, :hidden
  end
end
