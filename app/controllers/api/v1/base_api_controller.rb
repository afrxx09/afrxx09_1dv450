module Api
    module V1
        class BaseApiController < ApplicationController
            protect_from_forgery with: :null_session
            respond_to :json, :xml
            
            before_action :validate_api_key
            before_action :limit_and_offset, only: [:index]
            before_action :sort_order, only: [:index]
            
            rescue_from ActiveRecord::RecordNotFound, with: :not_found
            
            #rescue_from ActionController::UnknownFormat, with: :bad_request
            #rescue_from ActionController::RoutingError, with: :bad_request
            
            def routing_error
                bad_request
            end
            
            private
                def bad_request message = nil
                    message ||= 'Bad request'
                    respond_with message, status: 400
                end
                
                def not_found message = nil
                    message ||= 'Not found'
                    respond_with message, status: 404
                end
                
                def unauthorized message = nil
                    message ||= 'Unauthorized'
                    respond_with message, status: 401
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
                    offset = 0
                    limit = 5
                    if query_params[:offset].present?
                        @offset = query_params[:offset].to_i
                    end
                    if query_params[:limit].present?
                        @limit = query_params[:limit].to_i
                    end
                    @offset ||= offset
                    @limit ||= limit
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