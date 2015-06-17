class Vote < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: :User
  belongs_to :voteable, polymorphic: true


  def self.remove_old_vote voteable, user_id
    previous_vote = Vote.find_by(voteable: voteable, user_id: user_id)
    if previous_vote
      previous_vote.destroy
    end
    previous_vote
  end

end