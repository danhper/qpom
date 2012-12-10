# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
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
#  provider               :string(255)
#  uid                    :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:twitter, :facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  :name, :provider, :uid

  validates_presence_of :name, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  has_and_belongs_to_many :shops

  has_many :coupon_usages, dependent: :destroy
    
  has_many :coupons, :through => :coupon_usages do
    def used_coupon_number
      where("coupon_usages.times_used > ? ", 0).length
    end
    
  end

  has_one :user_settings


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    self.get_or_create_user(auth, signed_in_resource, auth.extra.raw_info.name)
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    self.get_or_create_user(auth, signed_in_resource, auth.info.nickname)
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if session.key?(:new_user)
        infos = session[:new_user]
        user.name = infos[:name]
        user.provider = infos[:provider]
        user.uid = infos[:uid]
        user.password = Devise.friendly_token[0, 20]
      end
    end
  end

  def received_coupon_number
    coupon_usages.length
  end

  def shared_coupon_number
    0
  end

  def registered_my_shop_number
    shops.length
  end

  def favorite_attribute
    []
  end

  def user_attribute
    []
  end

  def has?(coupon)
    coupon_usages.find_by_coupon_id(coupon.id)
  end

  def get!(coupon)
    coupon_usages.create!(coupon_id: coupon.id)
  end

  def drop!(coupon)
    coupon_usages.find_by_coupon_id(couopn.id).destroy
  end

  def use!(coupon)
    usage = coupon_usages.where("coupon_id = ?", coupon.id).first
    if usage.times_used < coupon.max_usage
      usage.times_used += 1
      usage.save
    else
      false
    end
  end

  def times_used(coupon)
    usage = coupon_usages.where("coupon_id = ?", coupon.id).first
    usage.times_used
  end

  private

  def self.get_or_create_user(auth, signed_in_resource=nil, name)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name: name,
       provider: auth.provider,
       uid: auth.uid,
       email: auth.info.email,
       password: Devise.friendly_token[0, 20]
       )
      user.save! if user.email?
    end
    user
  end
end
