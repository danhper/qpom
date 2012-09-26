class Station < ActiveRecord::Base
	attr_accessible :name

    has_many :shop
	belongs_to :train_line

end
