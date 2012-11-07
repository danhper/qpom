class AddMaxUsageToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :max_usage, :integer
  end
end
