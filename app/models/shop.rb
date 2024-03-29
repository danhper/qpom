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

class Shop < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :name_furigana, :phone_number, :representative, 
                  :account_name, :address, :business_hour, :access,
                  :open_time, :close_time, :area_id, :prefecture_id, :town_id, 
                  :fax, :description



  has_one :shop_settings, dependent: :destroy 
  has_one :genre

  has_and_belongs_to_many :users

  has_many :coupons, dependent: :destroy

  belongs_to :station
  belongs_to :area
  belongs_to :prefecture
  belongs_to :town


  validates_presence_of :account_name, :on => :create
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def station=(_station)
    @station = _station
    _station.shops << self
  end

  def created_coupon_number
    coupons.length
  end

  def sum_of_used_coupons_number
    coupons.inject(0){|sum, i| sum + i.used_times}
  end

  def sum_of_shared_coupons_number
    coupons.inject(0){|sum, i| sum + i.shared_coupon_number}
  end

  def self.search(params)
    shops = Shop.select('*')
    unless params[:free_word].nil? or params[:free_word].empty?
      q = "%#{params[:free_word]}%"
      shops = shops.where("name like ? or description like ?", q, q)
    end
    [:area, :prefecture, :town].each do |location|
      unless params[location].nil? or params[location].to_i == 0
        shops = shops.where("#{location}_id = ?", params[location].to_i)
      end
    end
    shops
  end
end
