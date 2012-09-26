# == Schema Information
#
# Table name: coupons
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  code                    :string(255)
#  use_times_left          :integer
#  description             :string(255)
#  sharable                :boolean
#  image                   :string(255)
#  validity_start_datetime :datetime
#  validity_end_datetime   :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Coupon < ActiveRecord::Base
  attr_accessible :code, :description, :image, :name, :sharable, 
  		:use_times_left, :validity_end_datetime, :validity_start_datetime

  belongs_to :shop

  has_many :coupon_usages
  has_many :users, :through => :coupon_usages
end
