class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :recipe_id, presence: true
  validates :ingredient_name, { presence: true, length: { maximum: 20 } }
  validates :quantity, numericality: { greater_than: 0 }
end
