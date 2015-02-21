class AppUrlsController < ApplicationController
	before_action :singed_in_api_user, only: [:create, :destroy] 
    
	def create
		@api_app = ApiApplication.find(params[:api_application_id])
		@app_url = @api_app.app_urls.build(app_url_params)
		if @app_url.save
			flash[:success] = 'Added URL!'
		else
			flash[:fail] = 'Failed to add URL!'
		end
		redirect_to @api_app
	end
	
	def destroy
		@api_app = ApiApplication.find(params[:api_application_id])
		AppUrl.find(params[:id]).destroy
		flash[:success] = 'removed URL!'
		redirect_to @api_app 
	end
	
	private
		def app_url_params
			params.require(:app_url).permit(:url)
		end
end
