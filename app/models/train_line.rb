# == Schema Information
#
# Table name: train_lines
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  train_company_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class TrainLine < ActiveRecord::Base
	attr_accessible :name

	belongs_to :train_company
	has_many :station
end
