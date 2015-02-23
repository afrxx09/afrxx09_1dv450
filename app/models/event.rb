class Event < ActiveRecord::Base
	has_many :eventstags
	has_many :tags, :through => :eventstags
	belongs_to :user
	belongs_to :position
	belongs_to :place
	
end
