class ChangeApiAppColumnOnAppUrl < ActiveRecord::Migration
  def change
  	remove_index :app_urls, :api_app_id
  	remove_column :app_urls, :api_app_id
  	add_column :app_urls, :api_application_id, :integer
  	add_index :app_urls, :api_application_id
  end
end
