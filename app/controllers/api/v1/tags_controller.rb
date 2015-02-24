module Api
    module V1
        class TagsController < BaseApiController
            
            def index                
                @tags = Tag.limit(@limit).offset(@offset).order(@order)
                respond_with @tags
            end
            
            def show
                @tag = Tag.find(params[:id])
                respond_with @tag
            end
            
            private

                def tag_params
                    params.require(:tag).permit(:tag)
                end
            
        end
    end
end