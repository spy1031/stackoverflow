class Upvote < ApplicationRecord
  belongs_to :user
  belongs_to :question, optional: true # 允許外鍵 nil
  belongs_to :solution, optional: true # 允許外鍵 nil
end
