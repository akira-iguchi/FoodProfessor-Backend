class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :recipe_name,    null: false
      t.string :recipe_image
      t.references :user,       foreign_key: true, null: false
      t.references :folder,     foreign_key: true, null: false

      t.timestamps
    end
  end
end
