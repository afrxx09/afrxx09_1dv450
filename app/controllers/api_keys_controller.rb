class ApiKeysController < ApplicationController
    before_action :singed_in_api_user, only: :create
    before_action :admin_api_user, only: :update

    def create
        @api_application = ApiApplication.find(params[:api_application_id])
        @api_key = @api_application.build_api_key(key: ApiKey.generate(current_api_user))
        if @api_key.save
            flash[:success] = 'New API-key generated.'
        else
            flash[:fail] = 'Could not generate new API-key'
        end
        redirect_to @api_application
    end

    #revoke
    def update
        @api_key = ApiKey.find(params[:id])
        @api_key.toggle(:revoked).save
        flash[:success] = @api_key.revoked ? 'API-key activated' : 'API-key revoked'
        if current_api_user.admin?
            redirect_to api_users_path
        else
            redirect_to @api_key.api_application
        end
        
    end

    private 
    
        def admin_api_user
            redirect_to(root_url) unless current_api_user.admin?
        end
end
