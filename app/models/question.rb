class Question < ApplicationRecord
  validates_presence_of :title, :content

  belongs_to :user, counter_cache: true
  
  # 問題能被很多使用者收藏 的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
  has_many :solutions
  
  has_many :upvotes, dependent: :destroy

  def is_favorited?(user)
    self.favorited_users.include?(user)
  end

  def have_voted?(user)
    self.upvotes.where("user_id = ?", user.id).exists?
  end

  def voted_upvote?(user)
    self.upvotes.where("user_id = ? AND status = ?", user.id, "up").exists?
  end
end
