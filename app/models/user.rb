class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :posts, dependent: :destroy
  has_many :comments

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 7..16 } 
end
