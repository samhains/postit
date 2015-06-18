class Category < ActiveRecord::Base
  include GenerateSlug
  has_many :post_categories
  has_many :posts, through: :post_categories
  validates :name, presence: :true, length: {minimum:2}
  after_validation :generate_slug


  def generate_slug
    self.slug = self.name.gsub(/[^0-9a-z ]/i, '').strip.gsub(' ','-').downcase
  end
end