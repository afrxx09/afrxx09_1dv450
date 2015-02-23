module Api
    module V1
        class PlacesController < ApplicationController
            
            respond_to :json
            
            rescue_from ActionController::UnknownFormat, with: :bad_req
            before_action :restrict_access, except: [:index, :show]
            
            def index
                @places = Place.all
                respond_with @places
            end

            def show
                @place = Place.find(params[:id])
                respond_with @place
            end
            
        end
    end
end