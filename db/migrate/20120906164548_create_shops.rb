class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.string :name_furigana
      t.string :phone_number
      t.string :representative

      t.timestamps
    end
  end
end
