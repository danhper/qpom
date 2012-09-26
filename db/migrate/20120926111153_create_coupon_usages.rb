class CreateCouponUsages < ActiveRecord::Migration
  def change
    create_table :coupon_usages do |t|

      t.timestamps
    end
  end
end
