class User < ActiveRecord::Base
  include GenerateSlug
  has_many :posts
  has_many :comments, inverse_of: :creator
  has_secure_password validations: false
  validates :username, presence: true, length: {minimum:5}, uniqueness: true
  validates :password, presence: true, length: {minimum:5}, on: :create
  has_many :votes
  sluggable_column :username

  def get_users_last_vote(voteable)
    vote = self.votes.find_by(voteable: voteable)
    vote.vote if vote
  end



end