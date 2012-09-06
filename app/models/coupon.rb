class Coupon < ActiveRecord::Base
  attr_accessible :code, :description, :image, :name, :sharable, 
  		:use_times_left, :validity_end_datetime, :validity_start_datetime

  belongs_to :shop
end
