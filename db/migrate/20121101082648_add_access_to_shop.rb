class AddAccessToShop < ActiveRecord::Migration
  def change
    add_column :shops, :access, :string
  end
end
