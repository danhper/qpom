# == Schema Information
#
# Table name: user_settings
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserSettings < ActiveRecord::Base
  # attr_accessible :title, :body
end
