class RenameEventsTags < ActiveRecord::Migration
  def change
  	rename_column :events_tags, :events_id, :event_id
  	rename_column :events_tags, :tags_id, :tag_id
  end
end
