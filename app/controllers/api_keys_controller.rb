class ApiKeysController < ApplicationController
    before_action :singed_in_user, only:[:create, :destroy]

    def create
        @api_key = current_user.build_api_key(key: ApiKey.generate(current_user))
        if @api_key.save
            flash[:success] = 'New API-key generated.'
        else
            flash[:fail] = 'Could not generate new API-key'
        end
        redirect_to current_user
    end

    def destroy
        @user = User.find(params[:id])
        @user.api_key.destroy
        flash[:success] = 'API-key deleted'
        if current_user.admin?
            redirect_to users_path
        else
            redirect_to current_user
        end
    end
end
