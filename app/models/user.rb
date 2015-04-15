class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, uniqueness: true

  after_initialize :set_session_token

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    if user
      return user if user.is_password?(password)
    end
    nil
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def set_session_token
    self.session_token ||= SecureRandom.base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64(16)
    self.save!
  end

end
