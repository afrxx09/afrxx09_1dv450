class ApiKey < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :key, presence: true

  def self.generate user
    Digest::MD5::hexdigest(user.email.downcase + Time.now.to_i.to_s);
  end
end
