class Post < ActiveRecord::Base
  include CountVotes
  include GenerateSlug
  belongs_to :creator, foreign_key: :user_id, class_name: :User
  has_many :comments, inverse_of: :post
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes ,  as: :voteable
  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  after_validation :generate_slug

  def generate_slug
    self.slug = self.title.gsub(/[^0-9a-z ]/i, '').strip.gsub(' ','-').downcase
  end

end