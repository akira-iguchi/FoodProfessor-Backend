class RecipeCategoryRelation < ApplicationRecord
  belongs_to :recipe
  belongs_to :category

  validates :recipe_id, presence: true
  validates :category_id, presence: true
  validates :recipe_time, numericality: { greater_than: 0, only_integer: true }, allow_blank: true
end
