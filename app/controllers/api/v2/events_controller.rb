module Api
    module V2
        class EventsController < BaseApiController
            before_action :api_auth, only: [:create, :update, :destroy]
            
            #Various ways to request events
            def index
                if params[:user_id].present? #By user_id
                    @events = User.find(params[:user_id]).events.limit(@limit).offset(@offset).order(@order)
                elsif params[:place_id].present? #By place_id
                    @events = Place.find(params[:place_id]).events.limit(@limit).offset(@offset).order(@order)
                elsif params[:tag_id].present? #By tag_id
                    @events = Tag.find(params[:tag_id]).events.limit(@limit).offset(@offset).order(@order)
                else #regular
                    @events = Event.includes([:user, :place, :tags]).limit(@limit).offset(@offset).order(@order)
                end
                
                respond_with @events, status: :ok
            end
            
            def show
                @event = Event.find(params[:id])
                respond_with @event, status: :ok
            end
            
            def create
                @event = Event.new
                @event.user_id = @current_user.id
                @event.place_id = params[:place_id]
                
                #Round down the decimals to group positions by roughly 11 meters
                lat = params[:lat].to_f.round(4)
                lng = params[:lng].to_f.round(4)
                #check if position already exists and save
                pos = Position.where(lng: lng, lat: lat).first
                if pos.nil?
                    @event.build_position(lat: lat, lng: lng)
                else
                    @event.position_id = pos.id
                end
                
                #add user comment to event
                @event.comment = params[:comment]
                
                #parse comment to search for hash-tags ex: "#yolo #swag"
                tags = @event.comment.scan(/#\S+/)
                
                tags.each do |t| #itterate found tags
                    existing_tag = Tag.find_by(tag: t) #Check if tag already exists
                    if !existing_tag.nil?
                        @event.tags << existing_tag #add existing tag
                    else
                        @event.tags.build(tag: t) #create new tag
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
                respond_with @events, status: :ok
            end
            
            def nearby
                if params[:lat].present? && params[:lng].present?
                    radius = params[:radius].present? ? params[:radius].to_i : 10 #
                    diff = radius/111.2 #111.2km = 1 degree lat or lng
                    lat = params[:lat].to_f
                    lng = params[:lng].to_f
                    @events = Event.joins(:position).where("(positions.lat > ? AND positions.lat < ?) AND (positions.lng > ? AND positions.lng < ?)", lat-diff, lat+diff, lng-diff, lng+diff)
                    respond_with @events, status: :ok
                else
                    bad_request "Nearby search needs parameters for Latitude(lat) and Longitude(lng)."
                end
            end

            
            private

                def event_params
                    params.require(:event).permit(:event, :event_id, :user_id, :place_id, :tag, :lat, :lng, :comment)
                end
            
        end
    end
end