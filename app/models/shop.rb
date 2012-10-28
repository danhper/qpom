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
#

class Shop < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :name_furigana, :phone_number, :representative, :account_name

  has_one :shop_settings, dependent: :destroy 
  has_one :genre

  has_many :coupons, dependent: :destroy

  belongs_to :station

  belongs_to :location

  validates_presence_of :account_name, :on => :create
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def station=(_station)
    @station = _station
    _station.shops << self
  end

end
