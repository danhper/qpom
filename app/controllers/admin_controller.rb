class AdminController < ApplicationController
  layout 'admin'

  def userlist
   @users = User.all
  end

  def shoplist
   @shops = Shop.all
  end

  def couponlist
	
  end

  def shop
  end
end
