class ApiUser < ActiveRecord::Base
	has_many :api_applications, dependent: :destroy
	attr_accessor :remember_token
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

	def ApiUser.digest string
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create string, cost:cost
	end

	def ApiUser.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = ApiUser.new_token
		update_attribute(:remember_digest, ApiUser.digest(remember_token))
	end

	def authenticated? remember_token
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	def forget
		update_attribute :remember_digest, nil
	end
end
