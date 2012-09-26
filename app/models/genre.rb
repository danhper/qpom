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
end
