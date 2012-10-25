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

class Location < ActiveRecord::Base
  attr_accessible :address

  has_many :shops

  belongs_to :prefecture
  belongs_to :town
  belongs_to :area
end
