class ApiApplication < ActiveRecord::Base
  belongs_to :api_user
  has_many :api_keys, dependent: :destroy
end
