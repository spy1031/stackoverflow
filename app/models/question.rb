class Question < ApplicationRecord
  validates_presence_of :title, :content

  belongs_to :user, counter_cache: true
end
