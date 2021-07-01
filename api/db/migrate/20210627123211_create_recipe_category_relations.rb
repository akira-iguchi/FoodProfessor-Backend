class CreateRecipeCategoryRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_category_relations do |t|
      t.references :recipe,      null: false, foreign_key: true
      t.references :category,    null: false, foreign_key: true

      t.timestamps
    end
  end
end
