class User < ActiveRecord::Base
  
  attr_accessor :activation_token
 
  before_save { self.email = email.downcase }
  validates :name, presence: true ,length: { maximum: 50 }
VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  

has_secure_password
validates :password, presence: true,  length: { minimum: 6 }

# Returns a random token.
def User.new_token
SecureRandom.urlsafe_base64
end

private

def downcase_email
self.email = email.downcase
end

def create_activation_digest
self.activation_token = User.new_token
self.activation_digest = User.digest(activation_token)
end

end