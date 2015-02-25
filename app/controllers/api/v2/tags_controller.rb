module Api
    module V2
        class TagsController < BaseApiController
            
            before_action :api_auth, only: [:create]
            
            def index                
                @tags = Tag.limit(@limit).offset(@offset).order(@order)
                respond_with @tags
            end
            
            def show
                @tag = Tag.find(params[:id])
                respond_with @tag
            end
            
            def create
                tag = Tag.new(tag_params)
                if tag.save
                    render json: { tag: tag }, status: :created
                else
                    render json: { error: tag.errors }, status: 400
                end
            end
            
            private

                def tag_params
                    #params.require(:tag).permit(:tag)
                    {
                        tag: params[:tag]
                    }
                end
            
        end
    end
end