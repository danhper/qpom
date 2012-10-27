class AddPrefectureIdToTowns < ActiveRecord::Migration
  def change
    add_column :towns, :prefecture_id, :integer
  end
end
