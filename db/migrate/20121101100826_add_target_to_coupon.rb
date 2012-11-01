class AddTargetToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :target, :string
  end
end
