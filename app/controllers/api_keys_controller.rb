class ApiKeysController < ApplicationController
    before_action :singed_in_user, only:[:generate, :destroy]
    def generate
        @api_key = current_user.build_api_key(key: ApiKey.generate)
        if @api_key.save
            flash[:success] = 'New API-key generated.'
        else
            flash[:fail] = 'Could not generate new API-key'
        end
        redirect_to current_user
    end

    def destroy
        @api_key.destroy
        flash[:success] = 'API-key deleted'
        redirect_to current_user
    end
end
