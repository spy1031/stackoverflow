class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  mount_uploader :avatar, AvatarUploader

  validates_presence_of :name
  validates_uniqueness_of :email

  has_many :questions, dependent: :destroy
  
  # 使用者能收藏很多問題 的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_questions, through: :favorites, source: :question
  
  # 使用者能對問題回答解答 的多對多關聯
  has_many :solutions, dependent: :destroy
  has_many :solutions_from_question, through: :solutions, source: :solution
  
  has_many :upvotes, dependent: :destroy

end
