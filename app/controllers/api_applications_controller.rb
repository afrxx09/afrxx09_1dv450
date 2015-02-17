class ApiApplicationsController < ApplicationController
	def new
		@api_user = ApiUser.find(params[:api_user_id])
		@api_app = ApiApplication.new
	end

	def create
		@api_app = ApiApplication.new(api_app_params)
		if @api_app.save
			sign_in @api_app
			flash[:success] = 'Sign up successful!'
			redirect_to @api_app
		else
			flash[:fail] = 'Failed sign up!'
			render 'new'
		end
	end

	private
		def api_app_params
			params.require(:api_application).permit(:name, :description)
		end
end
