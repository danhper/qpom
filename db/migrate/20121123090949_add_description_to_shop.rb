class AddDescriptionToShop < ActiveRecord::Migration
  def change
    add_column :shops, :description, :string
  end
end
