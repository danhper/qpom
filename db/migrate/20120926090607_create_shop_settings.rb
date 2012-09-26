class CreateShopSettings < ActiveRecord::Migration
  def change
    create_table :shop_settings do |t|

      t.timestamps
    end
  end
end
