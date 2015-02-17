module SessionsHelper
    def sign_in api_user
        session[:api_user_id] = api_user.id
    end

    def current_api_user
        if(api_user_id = session[:api_user_id])
            @current_api_user ||= ApiUser.find_by id: api_user_id
        elsif(api_user_id = cookies.signed[:api_user_id])
            api_user = ApiUser.find_by(id: api_user_id)
            if api_user && api_user.authenticated?(cookies[:remember_token])
                sign_in api_user
                @current_api_user = api_user
            end
        end
    end

    def signed_in?
        !current_api_user.nil?
    end

    def sign_out
        forget @current_api_user
        session.delete :api_user_id
        @current_api_user = nil
    end

    def remember api_user
        api_user.remember
        cookies.permanent.signed[:api_user_id] = api_user.id
        cookies.permanent[:remember_token] = api_user.remember_token
    end

    def forget api_user
        api_user.forget
        cookies.delete :api_user_id
        cookies.delete :remember_token
    end

    def current_api_user? api_user
        api_user == current_api_user
    end
end
