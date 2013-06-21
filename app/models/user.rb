class User < ActiveRecord::Base
  has_secure_password

  def self.login(email, password)
    User.find_by(email: email).try(:authenticate, password)
  end

end
