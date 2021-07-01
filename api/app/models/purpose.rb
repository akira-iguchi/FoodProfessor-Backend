class Purpose < ApplicationRecord
  belongs_to :recipe
  has_many :ingredients, dependent: :destroy
  has_many :procedures, dependent: :destroy

  validates :recipe_id, presence: true
  validates :purpose_name, { presence: true, length: { maximum: 50 } }
  validates :purpose_content, length: { maximum: 200 }
  validates :purpose_for_people, numericality: { greater_than: 0, only_integer: true }, allow_blank: true
  validates :purpose_time, numericality: { greater_than: 0, only_integer: true }, allow_blank: true
end
