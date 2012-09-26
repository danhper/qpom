class Coupon < ActiveRecord::Base
  attr_accessible :code, :description, :image, :name, :sharable, 
  		:use_times_left, :validity_end_datetime, :validity_start_datetime

  belongs_to :shop

  has_many :coupon_usages
  has_many :users, :through => :coupon_usages
end
