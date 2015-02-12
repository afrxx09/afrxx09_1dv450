module Api
    module V1
        class UsersController < ApplicationController
            
            respond_to :json
            
            rescue_from ActionController::UnknownFormat, with: :bad_req
            before_action :restrict_access, except: [:index]
            def index
                @users = User.all
                respond_with @users
            end

            def show
                @user = User.find(params[:id])
                respond_with @user
                rescue ActiveRecord::RecordNotFound
                @err = Object.new()
                @err.dev = '404 not found, check your id parameter.'
                @err.user = 'The requested resource could not be found but may be available again in the future. Subsequent requests by the client are permissible.'
                respond_with  @err, status: :not_found
            end

            def create
                respond_with User.create(params[:product])
            end

            def update
                respond_with User.update(params[:id], params[:products])
            end

            def destroy
                respond_with User.destroy(params[:id])
            end
            
            private
            
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
    end
end