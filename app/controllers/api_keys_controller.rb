class ApiKeysController < ApplicationController
    before_action :singed_in_user, only:[:create, :destroy]
    before_action :correct_user, only:[:create, :destroy]

    def create
        @api_key = current_api_user.build_api_key(key: ApiKey.generate(current_api_user))
        if @api_key.save
            flash[:success] = 'New API-key generated.'
        else
            flash[:fail] = 'Could not generate new API-key'
        end
        redirect_to current_api_user
    end

    def destroy
        @api_user = ApiUser.find(params[:id])
        @api_user.api_key.destroy
        flash[:success] = 'API-key deleted'
        if current_api_user.admin?
            redirect_to api_users_path
        else
            redirect_to current_api_user
        end
    end

    private 

        def correct_user
            @api_user = ApiUser.find(params[:id])
            redirect_to(root_path) unless current_user?(@api_user) || current_api_user.admin?
        end
end
