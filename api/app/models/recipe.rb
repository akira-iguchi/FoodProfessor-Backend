class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_category_relations, dependent: :destroy
  has_many :categories, through: :recipe_category_relations
  has_many :ingredients, dependent: :destroy
  has_many :procedures, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy

  mount_uploader :recipe_image, ImageUploader

  validates :user_id, presence: true
  validates :recipe_name, { presence: true, length: { maximum: 50 } }
  validates :recipe_time, {presence: true, numericality: { greater_than: 0, only_integer: true }}
  validates :for_how_many_people, {presence: true, numericality: { greater_than: 0, only_integer: true }}

  def is_favorite?(user)
    favorite_users.include?(user)
  end
end
