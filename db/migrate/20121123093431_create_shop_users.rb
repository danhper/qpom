class CreateShopUsers < ActiveRecord::Migration
  def change
    create_table :shops_users, id: false do |t|
      t.references :shop, :user
    end
    add_index :shops_users, [:shop_id, :user_id]
  end
end
