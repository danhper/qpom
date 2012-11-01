# == Schema Information
#
# Table name: prefectures
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  area_id    :integer
#

class Prefecture < ActiveRecord::Base
  attr_accessible :name

  belongs_to :area
  
  has_many :towns
end
