class Shop < ActiveRecord::Base
  attr_accessible :fax, :name_furigana, :phone_number, :representative

 has_one :shop_settings, dependent: :destroy 
 has_one :genre, dependent: :destroy
 has_many :coupon, dependent: :destroy
 belongs_to :station
end
