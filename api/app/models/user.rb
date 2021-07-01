class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
        :rememberable, :validatable, :recoverable, :trackable
  include DeviseTokenAuth::Concerns::User

  mount_uploader :user_image, ImageUploader

  validates :first_name, { presence: true, length: { maximum: 10 } }
  validates :last_name, { presence: true, length: { maximum: 10 } }

  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  has_many :relationship, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :relationship, source: :followed
  has_many :reverses_of_relationship, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :follower
  has_many :folders, dependent: :destroy
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def follow(other_user)
    relationship.create(followed_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship.find_by(followed_id: other_user.id).destroy if relationship
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
