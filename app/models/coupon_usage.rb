# == Schema Information
#
# Table name: coupon_usages
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CouponUsage < ActiveRecord::Base

    belongs_to :coupon
    belongs_to :user
end
