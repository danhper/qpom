class CreateRegistShops < ActiveRecord::Migration
  def change
    create_table :regist_shops do |t|
      t.string :account
      t.string :password

      t.timestamps
    end
  end
end
