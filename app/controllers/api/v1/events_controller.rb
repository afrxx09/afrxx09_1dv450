module Api
    module V1
        class EventsController < ApplicationController
            
            respond_to :json
            
            rescue_from ActionController::UnknownFormat, with: :bad_req
            before_action :restrict_access, except: [:index, :show]
            
            def index
                @events = Event.all
                respond_with @events
            end

            def show
                @event = Event.find(params[:id])
                respond_with @event
            end
            
        end
    end
end