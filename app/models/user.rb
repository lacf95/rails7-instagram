class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  # Followers
  has_many :followers_relationships, class_name: 'Relationship', foreign_key: :followed_id
  has_many :followers, through: :followers_relationships

  # Followeds
  has_many :followeds_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followeds, through: :followeds_relationships

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true

  def can_follow?(user)
    self != user && !followeds.include?(user)
  end

  def can_unfollow?(user)
    self != user
  end
end
