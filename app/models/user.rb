class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false }                
  validates :password, presence: true,
                       length: { minimum: 10 }
  validates :password_confirmation, presence: true,
                       length: { minimum: 10 }

  before_save do
    self.email.downcase!
  end

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
