class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
    	t.text :description
    	t.references :employee
    	t.references :topic
    	
      t.timestamps
    end
  end
end
