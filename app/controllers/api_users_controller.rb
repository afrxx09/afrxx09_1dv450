class ApiUsersController < ApplicationController
	before_action :singed_in_api_user, only: [:show, :index]
	before_action :correct_api_user, only: :show
	before_action :admin_api_user, only: :index

	def index
		@api_users = ApiUser.all
	end

	def show
		@api_user = ApiUser.find(params[:id])
	end
	def new
		@api_user = ApiUser.new
	end
	def create
		@api_user = ApiUser.new(api_user_params)
		if @api_user.save
			sign_in @api_user
			flash[:success] = 'Sign up successful!'
			redirect_to @api_user
		else
			flash[:fail] = 'Failed sign up!'
			render 'new'
		end
	end

	def update
		@api_user = ApiUser.find(params[:id])
		if @api_user.update_attributes api_user_params
			flash[:success] = 'Profile saved'
		else
			flash[:fail] = 'Could not save profile.'
		end
		render 'show'
	end
	
	private
		def api_user_params
			params.require(:api_user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
		end
		def correct_api_user
			@api_user = ApiUser.find(params[:id])
			redirect_to(root_path) unless current_api_user?(@api_user)
		end
		def admin_api_user
			redirect_to(root_url) unless current_api_user.admin?
		end
end
