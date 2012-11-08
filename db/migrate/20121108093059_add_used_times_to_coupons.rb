class AddUsedTimesToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :used_times, :integer
  end
end
