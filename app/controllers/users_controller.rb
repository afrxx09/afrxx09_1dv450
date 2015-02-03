class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end
	def new
		@user = User.new
	end
	def create
		@user = User.new(user_params)
		#@user.api_key = Digest::MD5::hexdigest(@user.email.downcase + Time.now.to_i.to_s);
		if @user.save
			flash[:success] = "Successfully signed up!"
			redirect_to @user
		else
			flash[:fail] = "Failed sign up!"
			render 'new'
		end
	end
	
	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end
end
