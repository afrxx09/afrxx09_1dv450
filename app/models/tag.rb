class Tag < ActiveRecord::Base
	has_many :events_tag
	has_many :events, :through => :events_tag
	validates :tag, uniqueness: true
end
