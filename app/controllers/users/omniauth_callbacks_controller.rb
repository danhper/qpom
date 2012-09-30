class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def facebook
        login_and_redirect("facebook")
    end

    def twitter
        login_and_redirect("twitter")
    end

    private

    def login_and_redirect(provider)
        @user = User.send("find_for_#{provider}_oauth", request.env["omniauth.auth"], current_user)
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider.capitalize
        sign_in_and_redirect @user, :event => :authentication
    end
end