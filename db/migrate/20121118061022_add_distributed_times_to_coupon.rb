class AddDistributedTimesToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :distributed_times, :integer
  end
end
