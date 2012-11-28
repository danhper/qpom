class Admins::RegistrationsController < Devise::RegistrationsController
  layout 'admin'

  def new
    render :file => "#{Rails.root}/public/404.html", :status => :not_found 
  end
end