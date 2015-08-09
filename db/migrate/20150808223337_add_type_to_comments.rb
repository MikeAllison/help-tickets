class AddTypeToComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.remove :closing_comment
      t.remove :reopening_comment
      t.column :status_type, :integer, default: 0
    end
  end
end
