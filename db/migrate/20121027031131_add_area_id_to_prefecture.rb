class AddAreaIdToPrefecture < ActiveRecord::Migration
  def change
    add_column :prefectures, :area_id, :integer
  end
end
