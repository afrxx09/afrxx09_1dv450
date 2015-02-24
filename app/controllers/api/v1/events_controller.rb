module Api
    module V1
        class EventsController < BaseApiController
            
            def index
                @events = Event.limit(@limit).offset(@offset).order(@order)
                respond_with @events
            end
            
            def show
                @event = Event.find(params[:id])
                respond_with @event
            end
            
            private

                def event_params
                    params.require(:event).permit(:user_id, :place_id, :position_id, :comment)
                end
            
        end
    end
end