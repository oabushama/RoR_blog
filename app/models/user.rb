class User < ActiveRecord::Base
  #has_many :articles
  has_many :articles, dependent: :destroy
  before_save {self.email = email.downcase }
  #validates :username, presence: true, uniqueness: true, #This has no case sensitive
  validates  :username, presence: true,
             uniqueness: { case_sensitive: false},
             length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates  :email, presence: true,
             uniqueness: { case_sensitive: false},
             length: { maximum: 105 },
             format: { with: VALID_EMAIL_REGEX }
             
  has_secure_password
end

#validations for user class
#username must be present and unique
#validate email format using regex