class AddSlugToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :slug, :string
  end
end
