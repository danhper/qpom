# == Schema Information
#
# Table name: train_companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TrainCompany < ActiveRecord::Base
	attr_accessible :name

	has_many :train_line
end
