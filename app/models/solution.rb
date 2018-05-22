class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :question
  
  has_many :upvotes, dependent: :destroy
  
  def have_voted?(user)
    self.upvotes.where("user_id = ?", user.id).exists?
  end

  def voted_upvote?(user)
    self.upvotes.where("user_id = ? AND status = ?", user.id, "up").exists?
  end
end
