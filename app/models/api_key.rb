class ApiKey < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :key, presence: true

  def ApiKey.generate
    Digest::MD5::hexdigest(self.user.email.downcase + Time.now.to_i.to_s);
  end
end
