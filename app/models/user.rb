class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, uniqueness: true

  after_initialize :set_session_token



  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  private
  def set_session_token
    self.session_token ||= SecureRandom.base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64(16)
  end

end
