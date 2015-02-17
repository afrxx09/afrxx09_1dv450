class RenameUserToApiUser < ActiveRecord::Migration
  def change
  	rename_table :users, :api_users
  end
end
