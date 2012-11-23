class AdminController < ApplicationController
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
