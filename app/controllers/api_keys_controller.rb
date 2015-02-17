class ApiKeysController < ApplicationController
    before_action :singed_in_api_user, only: :create
    before_action :correct_api_user, only: :create
    before_action :admin_api_user, only: :update

    def create
        @api_application = ApiApplication.find(params[:api_application_id])
        @api_key = @api_application.api_key.build(key: ApiKey.generate(current_api_user))
        if @api_key.save
            flash[:success] = 'New API-key generated.'
        else
            flash[:fail] = 'Could not generate new API-key'
        end
        redirect_to current_api_user
    end

    #revoke
    def update
        @api_key = ApiKey.find(params[:id])
        @api_key.toggle(:revoked)
        flash[:success] = 'API-key revoked'
        redirect_to api_users_path
    end

    private 
        def correct_api_user
            @api_user = ApiUser.find(params[:api_user_id])
            redirect_to(root_path) unless current_api_user?(@api_user)
        end
        
        def admin_api_user
            redirect_to(root_url) unless current_api_user.admin?
        end
end
