# == Schema Information
#
# Table name: genres
#
#  id               :integer          not null, primary key
#  main_category_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Genre < ActiveRecord::Base
  attr_accessible 

  belongs_to :main_category
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :sub_categories
end
