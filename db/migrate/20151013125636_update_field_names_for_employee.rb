class UpdateFieldNamesForEmployee < ActiveRecord::Migration
  def change
    change_table :employees do |t|
      t.rename :first_name, :fname
      t.rename :last_name, :lname
      t.rename :user_name, :username
    end
  end
end
