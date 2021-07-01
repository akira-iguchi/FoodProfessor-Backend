class Folder < ApplicationRecord
  belongs_to :user
  has_many :recipes, dependent: :destroy

  validates :user_id, presence: true
  validates :folder_name, { presence: true, length: { maximum: 50 } }
end
