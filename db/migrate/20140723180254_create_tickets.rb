class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
    	t.text :description
    	t.references :employee, index: true
    	t.references :topic, index: true

      t.timestamps
    end
  end
end
