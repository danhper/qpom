class AdminController < ApplicationController
  layout 'admin'

  def userlist
  end

  def shoplist
	  @shops = Shop.all
  end

  def couponlist
  end

  def shop
  end
end
