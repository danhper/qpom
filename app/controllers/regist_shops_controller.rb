class RegistShopsController < ApplicationController

 def index
  @shops = RegistShop.all
 end

end
