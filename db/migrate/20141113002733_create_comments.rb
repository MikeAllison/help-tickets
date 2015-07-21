class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :ticket, index: true
      t.references :employee, index: true
      t.text :body

      t.timestamps
    end
  end
end
