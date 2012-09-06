class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string, :name_furigana
      t.string, :representative
      t.string, :phone_number
      t.string :fax

      t.timestamps
    end
  end
end
