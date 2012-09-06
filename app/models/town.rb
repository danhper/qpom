class Town < ActiveRecord::Base
  attr_accessible :name, :prefecture_id
end
