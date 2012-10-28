class AddAccountNameToShops < ActiveRecord::Migration
  def change
    add_column :shops, :account_name, :string
  end
end
