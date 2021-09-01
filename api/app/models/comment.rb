class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :user_id, presence: true
  validates :recipe_id, presence: true
  validates :comment_content, { presence: true, length: { maximum: 200 } }
end
