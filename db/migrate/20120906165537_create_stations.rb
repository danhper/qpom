class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.integer :train_line_id

      t.timestamps
    end
  end
end
