class User < ActiveRecord::Base
  include GenerateSlug
  has_many :posts
  has_many :comments, inverse_of: :creator
  has_secure_password validations: false
  validates :username, presence: true, length: {minimum:5}, uniqueness: true
  validates :password, presence: true, length: {minimum:5}, on: :create
  has_many :votes
  after_validation :generate_slug


  def generate_slug
    self.slug = self.username.gsub(/[^0-9a-z ]/i, '').strip.gsub(' ','-').downcase
  end

  def get_users_last_vote(voteable)
    vote = self.votes.find_by(voteable: voteable)
    vote.vote if vote
  end
end