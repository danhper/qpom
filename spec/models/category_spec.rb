# == Schema Information
#
# Table name: categories
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  main_category_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Category do
  pending "add some examples to (or delete) #{__FILE__}"
end
