class RemoveDateTimeFromShops < ActiveRecord::Migration
  def up
    remove_column :shops, :start_time
    remove_column :shops, :end_time
  end

  def down
    add_column :shops, :end_time, :string
    add_column :shops, :start_time, :string
  end
end
