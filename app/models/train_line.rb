class TrainLine < ActiveRecord::Base
	attr_accessible :name

	belongs_to :train_company
	has_many :station
end
