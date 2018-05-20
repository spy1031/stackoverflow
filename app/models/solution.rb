class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :question
  
  has_many :upvotes, dependent: :destroy
  
end
