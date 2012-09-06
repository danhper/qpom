class CreateTrainLines < ActiveRecord::Migration
  def change
    create_table :train_lines do |t|
      t.string :name
      t.integer :train_company_id

      t.timestamps
    end
  end
end
