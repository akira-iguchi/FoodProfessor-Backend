class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :folder
  has_many :recipe_category_relations, dependent: :destroy
  has_many :purposes, dependent: :destroy
  has_many :comments, dependent: :destroy

  mount_uploader :user_image, ImageUploader

  validates :user_id, presence: true
  validates :folder_id, presence: true
  validates :recipe_name, { presence: true, length: { maximum: 50 } }
end
