class Category < ActiveRecord::Base
  include GenerateSlug
  has_many :post_categories
  has_many :posts, through: :post_categories
  validates :name, presence: :true, length: {minimum:2}
  sluggable_column :name

end