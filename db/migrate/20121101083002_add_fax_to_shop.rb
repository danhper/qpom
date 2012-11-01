class AddFaxToShop < ActiveRecord::Migration
  def change
    add_column :shops, :fax, :string
  end
end
