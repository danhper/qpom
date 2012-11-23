class AddTimesUsedToCouponUsage < ActiveRecord::Migration
  def change
    add_column :coupon_usages, :times_used, :integer
  end
end
