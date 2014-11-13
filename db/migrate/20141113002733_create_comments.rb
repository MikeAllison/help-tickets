class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :ticket
      t.references :employee
      t.text :body

      t.timestamps
    end
  end
end
