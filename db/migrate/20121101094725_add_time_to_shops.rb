class AddTimeToShops < ActiveRecord::Migration
  def change
    add_column :shops, :open_time, :time
    add_column :shops, :close_time, :time
  end
end
