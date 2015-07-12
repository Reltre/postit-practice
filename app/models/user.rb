class User < ActiveRecord::Base
  include SluggableJun

  has_secure_password validations: false

  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :votes

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 7..18 }, on: :create

  sluggable_column :username


  def is_admin?
    self.role == "admin"
  end

  def using_two_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10**6))
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end
end
