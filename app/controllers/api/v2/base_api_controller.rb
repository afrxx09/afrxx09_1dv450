module Api
    module V2
        class BaseApiController < ApplicationController
            protect_from_forgery with: :null_session
            respond_to :json, :xml
            
            before_action :validate_api_key
            before_action :limit_and_offset, only: [:index]
            before_action :sort_order, only: [:index]
            
            rescue_from ActiveRecord::RecordNotFound, with: :not_found
            
            #rescue_from ActionController::UnknownFormat, with: :bad_request
            #rescue_from ActionController::RoutingError, with: :bad_request
            
            def authenticate
                user = User.find_by(email: params[:email].downcase)
                if user && user.authenticate(params[:password])
                    token = encodeJWT user
                    render json: { user: user, token: token }
                else
                    unauthorized "Invalid email/password combination"
                end
            end
            
            def routing_error
                bad_request
            end
            
            private
                def bad_request message = nil
                    message ||= 'Bad request'
                    render json: { error: message }, status: 400
                end
                
                def not_found message = nil
                    message ||= 'Not found'
                    render json: { error: message }, status: 404
                end
                
                def unauthorized message = nil
                    message ||= 'Unauthorized'
                    render json: { error: message }, status: 401
                end
                
                def forbidden message = nil
                    message ||= 'Forbidden'
                    render json: { error: message }, status: 403
                end
                
                def validate_api_key
                    api_key = request.headers['X-ApiKey'] || query_params[:api_key]
                    if !ApiKey.exists?(key: api_key)
                        unauthorized
                    end
                end
                
                def query_params
                    params.permit(:api_key, :offset, :limit, :order)
                end
                
                def limit_and_offset
                    if query_params[:offset].present?
                        @offset = query_params[:offset].to_i
                    end
                    if query_params[:limit].present?
                        @limit = query_params[:limit].to_i
                    end
                    @offset ||= 0
                    @limit ||= 25
                    @next_offset = @limit + @offset
                    @prev_offset = @limit - @offset
                end
                
                def sort_order
                    @order = 'created_at DESC'
                    if query_params[:order].present?
                        if query_params[:order].upcase.eql?('ASC')
                            @order = 'created_at ASC'
                        end
                    end
                end

        end
    end
end