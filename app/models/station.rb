class Station < ActiveRecord::Base
	attr_accessible :name

	belongs_to :train_line
end
