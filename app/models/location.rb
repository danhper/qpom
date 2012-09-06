class Location < ActiveRecord::Base
  attr_accessible :address, :prefecture_id, :town_id
end
