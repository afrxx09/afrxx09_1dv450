module Api
    module V1
        class TagsController < ApplicationController
            
            respond_to :json
            
            rescue_from ActionController::UnknownFormat, with: :bad_req
            before_action :restrict_access, except: [:index, :show]
            
            def index
                @tags = Tag.all
                respond_with @tags
            end

            def show
                @tag = Tag.find(params[:id])
                respond_with @tag
            end
            
        end
    end
end