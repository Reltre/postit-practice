class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, length: {minimum: 2}, uniqueness: true

  before_save :generate_slug

  def generate_slug
    a_slug = name.parameterize
    return slug if slug != nil && slug[0..-3] == a_slug
    slug_copies = Category.where("slug LIKE :prefix",prefix: "#{a_slug}%").size
    self.slug = slug_copies.zero? ? a_slug : "#{a_slug}-#{slug_copies + 1}"
  end

  def to_param
    slug
  end
end
