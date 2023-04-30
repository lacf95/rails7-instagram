class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :image
  has_rich_text :description

  validates :image, presence: true
  validates :description, presence: true
end
