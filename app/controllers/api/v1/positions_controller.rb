module Api
    module V1
        class PositionsController < ApplicationController
            
            respond_to :json
            
            rescue_from ActionController::UnknownFormat, with: :bad_req
            before_action :restrict_access, except: [:index, :show]
            
            def index
                @positions = Position.all
                respond_with @positions
            end

            def show
                @position = Position.find(params[:id])
                respond_with @position
            end
            
        end
    end
end