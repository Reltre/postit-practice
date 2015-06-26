class Post < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories


  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true

  validates :description, presence: true
  validates :category_ids, :presence => {:message => 'At least 1 category must be selected'}

  before_save :generate_slug

  def generate_slug
    a_slug = title.parameterize
    return slug if slug != nil && slug[0..-3] == a_slug
    slug_copies = Post.where("slug LIKE :prefix",prefix: "#{a_slug}%").size
    self.slug = slug_copies.zero? ? a_slug : "#{a_slug}-#{slug_copies + 1}"
  end

  def to_param
    slug
  end
end
