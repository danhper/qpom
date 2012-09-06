class CreateTrainCompanies < ActiveRecord::Migration
  def change
    create_table :train_companies do |t|
      t.string :name

      t.timestamps
    end
  end
end
