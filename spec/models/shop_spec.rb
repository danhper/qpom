# == Schema Information
#
# Table name: shops
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  name_furigana          :string(255)
#  phone_number           :string(255)
#  representative         :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  account_name           :string(255)
#  prefecture_id          :integer
#  area_id                :integer
#  town_id                :integer
#  address                :string(255)
#  access                 :string(255)
#  fax                    :string(255)
#  open_time              :time
#  close_time             :time
#  description            :string(255)
#

require 'spec_helper'

describe Shop do
  pending "add some examples to (or delete) #{__FILE__}"
end
