class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :votes

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 7..18 }, on: :create

  before_save :generate_slug

  def generate_slug
    a_slug = username.parameterize
    return slug if slug != nil && slug[0..-3] == a_slug
    slug_copies = User.where("slug LIKE :prefix",prefix: "#{a_slug}%").size
    self.slug = slug_copies.zero? ? a_slug : "#{a_slug}-#{slug_copies + 1}"
  end

  def to_param
    slug
  end
end
