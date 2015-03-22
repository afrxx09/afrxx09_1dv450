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
    
    def api_auth
        if request.headers["Authorization"].present?
            auth_header = request.headers['Authorization'].split(' ').last
            payload = decodeJWT auth_header.strip
            if !payload
                render json: { error: 'Incorrect token' }, status: 400
            else
                @current_user = User.find(payload[0]['user_id'])
            end
        else
            render json: { error: 'No Authorization header' }, status: 403
        end
    end
    
    def encodeJWT user
        payload = { user_id: user.id }
        payload[:exp] = 2.hours.from_now.to_i
        JWT.encode( payload, Rails.application.secrets.secret_key_base, "HS512")
    end

    def decodeJWT token
        payload = JWT.decode(token, Rails.application.secrets.secret_key_base, "HS512")
        if payload[0]["exp"] >= Time.now.to_i
            payload
        else
            false
        end
        rescue => error
            nil
    end
end
