class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.integer :main_category_id

      t.timestamps
    end
  end
end
