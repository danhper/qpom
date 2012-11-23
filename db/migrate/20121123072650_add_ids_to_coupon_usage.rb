class AddIdsToCouponUsage < ActiveRecord::Migration
  def change
    add_column :coupon_usages, :user_id, :integer
    add_column :coupon_usages, :coupon_id, :integer
  end
end
