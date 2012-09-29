# == Schema Information
#
# Table name: shop_settings
#
#  id         :integer          not null, primary key
#  shop_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShopSettings < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :shop
end
