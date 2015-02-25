module Api
    module V2
        class PositionsController < BaseApiController
            before_action :api_auth, only: [:create]
            
            def index
                @positions = Positionlimit(@limit).offset(@offset).order(@order)
                respond_with @positions
            end
            
            def show
                @position = Position.find(params[:id])
                respond_with @position
            end
            
            def create
                position = Position.new(position_params)
                if position.save
                    render json: { position: position }, status: :created
                else
                    render json: { error: position.errors }, status: 400
                end
            end
            
            private

                def position_params
                    #params.require(:position).permit(:lat, :lng)
                    {
                        lat: params[:lat],
                        lng: params[:lng]
                    }
                end
            
        end
    end
end