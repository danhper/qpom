# == Schema Information
#
# Table name: consumers
#
#  id         :integer          not null, primary key
#  nickname   :string(255)
#  twitter    :string(255)
#  facebook   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Consumer do
  pending "add some examples to (or delete) #{__FILE__}"
end
