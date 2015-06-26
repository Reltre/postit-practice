class User < ActiveRecord::Base
  include Sluggable

  has_secure_password validations: false

  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :votes

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 7..18 }, on: :create
  
end
