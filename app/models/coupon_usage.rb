# == Schema Information
#
# Table name: coupon_usages
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  times_used :integer
#  user_id    :integer
#  coupon_id  :integer
#

class CouponUsage < ActiveRecord::Base
  attr_accessible :times_used, :coupon_id
  belongs_to :coupon
  belongs_to :user

  after_initialize :init

  def init
    self.times_used ||= 0
  end

  validates :coupon_id, presence: true
  validates :user_id, presence: true
end
