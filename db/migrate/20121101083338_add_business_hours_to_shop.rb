class AddBusinessHoursToShop < ActiveRecord::Migration
  def change
    add_column :shops, :start_time, :datetime
    add_column :shops, :end_time, :datetime
  end
end
