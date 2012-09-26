# == Schema Information
#
# Table name: stations
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  train_line_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Station < ActiveRecord::Base
	attr_accessible :name

    has_many :shops
	belongs_to :train_line
end
