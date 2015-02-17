class AddRevokedToApiKey < ActiveRecord::Migration
  def change
  	add_column :api_keys, :revoked, :boolean, default: false
  end
end
