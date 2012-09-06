class Location < ActiveRecord::Base
  attr_accessible :address

  belongs_to :prefecture
  belongs_to :town
end
