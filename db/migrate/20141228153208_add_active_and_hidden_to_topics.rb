class AddActiveAndHiddenToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :active, :boolean, default: true
    add_column :topics, :hidden, :boolean, default: false
  end
end
