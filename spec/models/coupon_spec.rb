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

require 'spec_helper'

describe Coupon do
  pending "add some examples to (or delete) #{__FILE__}"
end
