class AddLocationToShop < ActiveRecord::Migration
  def change
    add_column :shops, :prefecture_id, :integer
    add_column :shops, :area_id, :integer
    add_column :shops, :town_id, :integer
    add_column :shops, :address, :string
  end
end
