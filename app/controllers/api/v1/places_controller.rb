module Api
    module V1
        class PlacesController < BaseApiController
            
            def index
                @places = limit(@limit).offset(@offset).order(@order)
                respond_with @places
            end
            
            def show
                @place = Place.find(params[:id])
                respond_with @place 
            end
                        
            private

                def place_params
                    params.require(:place).permit(:name, :address, :city, :zip)
                end
            
        end
    end
end