class CreateApiRequests < ActiveRecord::Migration
  def change
    create_table :api_requests do |t|
      t.references :api_key, index: true
      t.string :url
      t.string :resource
      t.string :action

      t.timestamps
    end
  end
end
