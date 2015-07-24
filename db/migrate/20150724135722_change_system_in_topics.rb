class ChangeSystemInTopics < ActiveRecord::Migration
  def change
    rename_column :topics, :system, :name
  end
end
