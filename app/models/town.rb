# == Schema Information
#
# Table name: towns
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Town < ActiveRecord::Base
  attr_accessible :name

  belongs_to :prefecture
end
