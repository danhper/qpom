# == Schema Information
#
# Table name: stations
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  train_line_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Station do
  pending "add some examples to (or delete) #{__FILE__}"
end
