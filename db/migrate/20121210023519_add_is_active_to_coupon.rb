class AddIsActiveToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :is_active, :boolean
  end
end
