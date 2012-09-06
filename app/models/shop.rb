class Shop < ActiveRecord::Base
  attr_accessible :fax, :name_furigana, :phone_number, :representative

  has_one :shop_settings, dependent: true
  has_one :genre, dependent: true
  has_many :coupon, dependent: true
  belongs_to :station
end
