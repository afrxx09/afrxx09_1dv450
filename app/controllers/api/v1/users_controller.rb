module Api
    module V1
        class UsersController < BaseApiController
            
            def index
                @users = User.limit(@limit).offset(@offset).order(@order)
                respond_with @users
            end
            
            def show
                @user = User.find(params[:id])
                respond_with @user
            end
                        
            private

                def user_params
                    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
                end
            
        end
    end
end