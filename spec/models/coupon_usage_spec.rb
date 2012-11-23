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

require 'spec_helper'

describe CouponUsage do
  pending "add some examples to (or delete) #{__FILE__}"
end
