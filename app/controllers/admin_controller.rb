class AdminController < ApplicationController
  before_filter :authenticate_admin!
  layout 'admin'

  def userlist
   @users = User.all
  end

  def shoplist
   @shops = Shop.all
  end

  def couponlist
	  @coupons = Coupon.all	
  end

  def shop
  end
end
