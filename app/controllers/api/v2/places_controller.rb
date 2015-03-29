module Api
    module V2
        class PlacesController < BaseApiController
            before_action :api_auth, only: [:create]
            
            def index
                @places = Place.limit(@limit).offset(@offset).order(@order)
                respond_with @places
            end
            
            def show
                @place = Place.find(params[:id])
                respond_with @place 
            end
            
            def create
                place = Place.new(place_params)
                if place.save
                    render json: { place: place }, status: :created
                else
                    render json: { error: place.errors }, status: 400
                end
            end
            
            def google_place_id
                @place = Place.find_by google_place_id: params[:google_place_id]
                respond_with @place
            end
                        
            private

                def place_params
                    #params.require(:place).permit(:name, :address, :city, :zip)
                    {
                        name: params[:name],
                        address: params[:address],
                        city: params[:city],
                        zip: params[:zip],
                        google_place_id: params[:google_place_id],
                        lat: params[:lat],
                        lng: params[:lng]
                    }
                end
            
        end
    end
end