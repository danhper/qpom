class TrainCompany < ActiveRecord::Base
	attr_accessible :name

	has_many :train_line
end
