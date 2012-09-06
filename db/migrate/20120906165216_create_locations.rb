class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.integer :prefecture_id
      t.integer :town_id

      t.timestamps
    end
  end
end
