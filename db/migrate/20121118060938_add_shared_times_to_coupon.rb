class AddSharedTimesToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :shared_times, :integer
  end
end
