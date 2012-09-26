# == Schema Information
#
# Table name: main_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MainCategory < ActiveRecord::Base
  attr_accessible :name
end
