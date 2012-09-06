class Shop < ActiveRecord::Base
  attr_accessible :fax, :name_furigana, :phone_number, :representative,
  		:shop_settings_id, :settings_id, :genre_id, :location_id
end
