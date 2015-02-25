module Api
    module V2
        class EventsController < BaseApiController
            before_action :api_auth, only: [:create, :update, :destroy]
            
            def index
                if params[:user_id].present?
                    @events = User.find(params[:user_id]).events.limit(@limit).offset(@offset).order(@order)
                elsif params[:place_id].present?
                    @events = Place.find(params[:place_id]).events.limit(@limit).offset(@offset).order(@order)
                elsif params[:tag_id].present?
                    @events = Tag.find(params[:tag_id]).events.limit(@limit).offset(@offset).order(@order)
                else
                    @events = Event.includes([:user, :place, :tags]).limit(@limit).offset(@offset).order(@order)
                end
                
                respond_with @events
            end
            
            def show
                @event = Event.find(params[:id])
                respond_with @event
            end
            
            def create
                @event = Event.new
                @event.user_id = @current_user.id
                @event.place_id = params[:place_id]
                @event.build_position(lat: params[:lat], lng: params[:lng])
                @event.comment = params[:comment]
                tags = @event.comment.scan(/#\S+/)
                
                tags.each do |t|
                    existing_tag = Tag.find_by(tag: t)
                    if !existing_tag.nil?
                        @event.tags << existing_tag
                    else
                        @event.tags.build(tag: t) 
                    end
                end
                
                if @event.save
                    respond_with @events, status: :created
                else
                    render json: { errors: @event.errors }
                end
                
            end
            
            def update
                @event = Event.find(params[:id])
                if @event.user_id == @current_user.id
                    if @event.update_attributes(comment: params[:comment])
                        respond_with @event
                    else
                        render json: { errors: @event.errors }
                    end
                else
                    forbidden 'Users are only able to edit their own events'
                end
            end
            
            def destroy
                @event = Event.find(params[:id])
                if @event.user_id == @current_user.id
                    @event.destroy
                    respond_with nil
                else
                    forbidden 'Users can only delete their own events'
                end
            end
            
            def search
                @events = Event.where("comment LIKE ?", "%#{params[:query]}%")
                respond_with @events
            end
            
            private

                def event_params
                    params.require(:event).permit(:event, :event_id, :user_id, :place_id, :tag, :lat, :lng, :comment)
                end
            
        end
    end
end