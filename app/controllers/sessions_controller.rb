class SessionsController < ApplicationController
    skip_before_filter :require_login, :except => [:destroy]

    def new
        @user = User.new
    end 

    def create
        user = login(params[:username], params[:password])
        if user
            redirect_back_or_to root_url, :notice => "Logged in!"
        else
            flash.now.alert = "Invalid username or password"
            render :new
        end
    end

    def destroy
        logout
        redirect_to root_url, :notice => "Looged out"
    end
    
end