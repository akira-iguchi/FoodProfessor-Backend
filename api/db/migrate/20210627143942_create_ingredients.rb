class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.string :ingredient_name,           null: false
      t.string :quantity,                   null: false
      t.references :recipe,               foreign_key: true, null: false

      t.timestamps
    end
  end
end
