class RemoveUserAddApplicationToApiKey < ActiveRecord::Migration
  def change
  	remove_index :api_keys, :user_id
  	remove_column :api_keys, :user_id
  	add_column :api_keys, :api_application_id, :integer
  	add_index :api_keys, :api_application_id
  end
end
