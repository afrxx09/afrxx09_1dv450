class Event < ActiveRecord::Base
	has_many :events_tag
	has_many :tags, :through => :events_tag
	belongs_to :user
	belongs_to :position
	belongs_to :place
	
end
