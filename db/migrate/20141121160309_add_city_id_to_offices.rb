class AddCityIdToOffices < ActiveRecord::Migration
  def change
    add_reference :offices, :city, index: true
  end
end
