# == Schema Information
#
# Table name: locations
#
#  id            :integer          not null, primary key
#  address       :string(255)
#  prefecture_id :integer
#  town_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Location do
  pending "add some examples to (or delete) #{__FILE__}"
end
