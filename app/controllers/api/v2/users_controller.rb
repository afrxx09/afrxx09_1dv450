module Api
    module V2
        class UsersController < BaseApiController
            
            def index
                @users = User.includes([:events]).limit(@limit).offset(@offset).order(@order)
                respond_with @users
            end
            
            def show
                @user = User.includes([:events]).find(params[:id])
                respond_with @user
            end
            
            def create
                user = User.new(user_params)
                if user.save
                    token = encodeJWT user
                    render json: { user: user, token: token }
                else
                    render json: { errors: user.errors }
                end
            end
                        
            private

                def user_params
                    #doesn't work
                    #json_params = ActionController::Parameters.new( JSON.parse(request.body.read) )
                    #json_params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
                    
                    #doesn't work
                    #params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
                    
                    #http://stackoverflow.com/a/20668748
                    {
                        email: params[:email],
                        first_name: params[:first_name],
                        last_name: params[:last_name],
                        password: params[:password],
                        password_confirmation: params[:password_confirmation]
                    }
                end
            
        end
    end
end