class CreateApiApplications < ActiveRecord::Migration
  def change
    create_table :api_applications do |t|
      t.string :name
      t.string :description
      t.references :api_user, index: true

      t.timestamps
    end
  end
end
