class SubCategory < ActiveRecord::Base
  attr_accessible :name

  belongs_to :category
end
