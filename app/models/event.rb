class Event < ActiveRecord::Base
	has_many :eventstags
	has_many :tags, :through => :eventstags
	has_one :user
	has_one :position
	has_one :place
	
end
