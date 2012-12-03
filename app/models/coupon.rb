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
#  shop_id                 :integer
#  used_times              :integer
#  shared_times            :integer
#  distributed_times       :integer
#

class Coupon < ActiveRecord::Base
  attr_accessible :code, :description, :image, :name, :sharable,
                  :validity_end_datetime, :validity_start_datetime,
                  :target, :max_usage, :image_file, :used_times

  attr_accessor :image_file

  after_initialize :init


  belongs_to :shop

  has_many :coupon_usages, dependent: :destroy
  has_many :users, through: :coupon_usages

  def init
    self.used_times ||= 0
    self.shared_times ||= 0
    self.distributed_times ||= 0
    self.max_usage ||= 1
  end


  def shop=(_shop)
    @shop = _shop
    _shop.coupons << self
  end

  def self.top(limit=20)
    coupons = Coupon.where('validity_end_time >= ?', Time.now)
    coupons.order('created_at DESC').limit(limit)
  end

  def shared_coupon_number
    0
  end
end
