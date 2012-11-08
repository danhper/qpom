# == Schema Information
#
# Table name: coupons
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  code                    :string(255)
#  description             :string(255)
#  sharable                :boolean
#  image                   :string(255)
#  validity_start_datetime :datetime
#  validity_end_datetime   :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  target                  :string(255)
#  max_usage               :integer
#  shop_id                 :string(255)
#

class Coupon < ActiveRecord::Base
    attr_accessible :code, :description, :image, :name, :sharable,
        :use_times_left, :validity_end_datetime, :validity_start_datetime,
        :target, :max_usage, :image_file, :used_times

    attr_accessor :image_file


    belongs_to :shop

    has_many :coupon_usages
    has_many :users, :through => :coupon_usages


    def shop=(_shop)
        @shop = _shop
        _shop.coupons << self
    end
end
