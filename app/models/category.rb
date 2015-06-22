class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, length: {minimum: 2}, uniqueness: true

  before_save :generate_slug

  def generate_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end
end
