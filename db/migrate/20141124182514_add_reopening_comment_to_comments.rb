class AddReopeningCommentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :reopening_comment, :boolean, default: false
  end
end
