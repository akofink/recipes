class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :password_confirmation, unless: 'password.blank?'

  def self.login(email, password)
    User.find_by(email: email).try(:authenticate, password)
  end

end
