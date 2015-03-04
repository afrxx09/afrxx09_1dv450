module Api
    module V2
        class PlacesController < BaseApiController
            before_action :api_auth, only: [:create]
            
            def index
                @places = limit(@limit).offset(@offset).order(@order)
                respond_with @places
            end
            
            def show
                @place = Place.find(params[:id])
                respond_with @place 
            end
            
            def create
                place = Position.new(place_params)
                if place.save
                    render json: { place: place }, status: :created
                else
                    render json: { error: place.errors }, status: 400
                end
            end
                        
            private

                def place_params
                    #params.require(:place).permit(:name, :address, :city, :zip)
                    {
                        name: params[:name],
                        address: params[:address],
                        city: params[:city],
                        zip: params[:zip]
                    }
                end
            
        end
    end
end