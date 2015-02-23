class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private
    def singed_in_api_user
      unless signed_in?
        flash[:fail] = "Please sign in"
        redirect_to sign_in_path
      end
    end
            
    def restrict_access
        authenticate_or_request_with_http_token do |token, options|
            ApiKey.exists?(key: token)
        end
    end
    
    def bad_req
        @err = Object.new()
        @err.dev = '400 bad request, check your request-path.'
        @err.user = 'The server cannot or will not process the request due to something that is perceived to be a client error.'
        render json: @error, status: :bad_request
    end
end
