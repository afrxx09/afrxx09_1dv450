class UsersController < ApplicationController
	before_action :singed_in_user, only:[:show]
	def show
		@user = User.find(params[:id])
	end
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = 'Sign up successful!'
			redirect_to @user
		else
			flash[:fail] = 'Failed sign up!'
			render 'new'
		end
	end
	
	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end
end
