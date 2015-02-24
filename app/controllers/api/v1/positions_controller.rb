module Api
    module V1
        class PositionsController < BaseApiController
            
            def index
                @positions = Positionlimit(@limit).offset(@offset).order(@order)
                respond_with @positions
            end
            
            def show
                @position = Position.find(params[:id])
                respond_with @position
            end
            
            private

                def position_params
                    params.require(:position).permit(:lat, :lng)
                end
            
        end
    end
end