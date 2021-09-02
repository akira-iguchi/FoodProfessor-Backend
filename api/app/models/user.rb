class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
        :rememberable, :validatable, :recoverable, :trackable
  include DeviseTokenAuth::Concerns::User

  mount_uploader :profile_image, ImageUploader

  validates :first_name, { presence: true, length: { maximum: 10 } }
  validates :last_name, { presence: true, length: { maximum: 10 } }

  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  has_many :recipes, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorite_recipes, through: :favorites, source: :recipe

  has_many :comments, dependent: :destroy

  def favorite(recipe)
    favorites.find_or_create_by(recipe_id: recipe.id)
  end

  def unfavorite(recipe)
    favorite = favorites.find_by(recipe_id: recipe.id)
    favorite.destroy if favorite
  end

  def favorite?(recipe)
    favorite_recipes.include?(recipe)
  end
end
