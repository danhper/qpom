class Shop < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name_furigana, :phone_number, :representative

  has_one :shop_settings, dependent: :destroy 
  has_one :genre, dependent: :destroy

  has_many :coupons, dependent: :destroy

  belongs_to :station
end
