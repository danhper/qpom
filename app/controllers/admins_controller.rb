class Admins::SessionsController < Devise::SessionsController
  layout 'admin'
end

class Admins::RegistrationsController < Devise::RegistrationsController
  layout 'admin'
end