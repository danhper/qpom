# == Schema Information
#
# Table name: towns
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prefecture_id :integer
#

require 'spec_helper'

describe Town do
  pending "add some examples to (or delete) #{__FILE__}"
end
