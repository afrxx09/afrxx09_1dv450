class ApiApplication < ActiveRecord::Base
	belongs_to :api_user
	has_one :api_key
	has_many :app_urls

	validates :name, presence: true
	validates :description, presence: true

	accepts_nested_attributes_for :api_key
	accepts_nested_attributes_for :app_urls
end
