# == Schema Information
#
# Table name: categories
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  main_category_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Category < ActiveRecord::Base
  attr_accessible :name

  belongs_to :main_category
end
