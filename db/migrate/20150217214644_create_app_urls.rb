class CreateAppUrls < ActiveRecord::Migration
  def change
    create_table :app_urls do |t|
      t.string :url
      t.references :api_app, index: true

      t.timestamps
    end
  end
end
