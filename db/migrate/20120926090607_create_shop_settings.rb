class CreateShopSettings < ActiveRecord::Migration
  def change
    create_table :shop_settings do |t|
      t.integer :shop_id

      t.timestamps
    end
  end
end
