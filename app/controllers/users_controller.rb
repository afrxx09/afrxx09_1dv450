class UsersController < ApplicationController
	before_action :singed_in_user, only: [:show, :index]
	before_action :correct_user, only: :show
	before_action :admin_user, only: :index

	def index
		@users = User.all
	end

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

	def update
		@user = User.find(params[:id])
		if @user.update_attributes user_params
			flash[:success] = 'Profile saved'
			render 'show'
		else
			render 'show'
		end
	end
	
	private
		def user_params
			params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end
end
