class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string, :name
      t.string, :code
      t.integer, :use_times_left
      t.string, :description
      t.boolean, :sharable
      t.string, :image
      t.datetime, :validity_start_datetime
      t.datetime :validity_end_datetime

      t.timestamps
    end
  end
end
