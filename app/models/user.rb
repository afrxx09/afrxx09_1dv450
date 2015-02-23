class User < ActiveRecord::Base
	has_many :events
	
	has_secure_password
	before_save { email.downcase! }
	validates :first_name,
		presence: true,
		length: { maximum: 50 }
	validates :last_name,
		presence: true,
		length: { maximum: 50 }
	validates :email, 
		presence: true,
		length: { maximum: 255 },
		format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
		uniqueness: { case_sensitive: false }
	validates :password,
		length: { minimum: 6 },
		allow_blank: true
end
