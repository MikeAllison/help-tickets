class AddClosingCommentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :closing_comment, :boolean, default: false
  end
end
