# == Schema Information
#
# Table name: coupon_usages
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  times_used :integer
#

class CouponUsage < ActiveRecord::Base
    attr_accessible :times_used
    belongs_to :coupon
    belongs_to :user
end
