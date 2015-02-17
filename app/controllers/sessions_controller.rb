class SessionsController < ApplicationController
    def new

    end

    def create
        api_user = ApiUser.find_by(email: params[:session][:email].downcase)
        if api_user && api_user.authenticate(params[:session][:password])
            sign_in api_user
            params[:session][:remember_me] == '1' ? remember(api_user) : forget(api_user)
            if api_user.admin?
                redirect_to api_users_path
            else
                redirect_to api_user
            end
        else
            flash[:fail] = 'api_username or password incorrect'
            render 'new'
        end
    end

    def destroy
        sign_out if signed_in?
        redirect_to root_path
    end
end
