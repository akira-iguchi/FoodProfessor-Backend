class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :recipe_id, presence: true
  validates :ingredient_name, { presence: true, length: { maximum: 10 } }
  validates :quantity, { presence: true, length: { maximum: 10 } }
end
