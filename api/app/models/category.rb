class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', foreign_key: :parent_id, optional: true
  has_many :children, class_name: 'Category', foreign_key: :parent_id
  has_many :recipe_category_relations

  validates :category_name, { presence: true, length: { maximum: 20 } }
end
