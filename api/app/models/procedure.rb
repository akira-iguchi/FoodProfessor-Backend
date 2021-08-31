class Procedure < ApplicationRecord
  belongs_to :recipe

  validates :recipe_id, presence: true
  validates :procedure_content, { presence: true, length: { maximum: 300 } }
end