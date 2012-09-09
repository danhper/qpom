class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :nickname
      t.string :twitter
      t.string :facebook

      t.timestamps
    end
  end
end
