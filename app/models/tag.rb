class Tag < ActiveRecord::Base
	has_many :eventstags
	has_many :events, :through => :eventstags
end
