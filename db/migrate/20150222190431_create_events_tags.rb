class CreateEventsTags < ActiveRecord::Migration
  def change
    create_table :events_tags do |t|
      t.references :events, index: true
      t.references :tags, index: true

      t.timestamps
    end
  end
end
