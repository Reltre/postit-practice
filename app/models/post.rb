class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'

  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true

  validates :description, presence: true
  validates :category_ids, :presence => {:message => 'At least 1 category must be selected'}

  before_save :generate_slug

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  def generate_slug
    #the_slug = title.parameterize
    self.slug = title.parameteriz
  end

  def to_param
    slug
  end
end
