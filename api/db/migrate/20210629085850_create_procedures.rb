class CreateProcedures < ActiveRecord::Migration[6.1]
  def change
    create_table :procedures do |t|
      t.text :procedure_content,        null: false
      t.integer :order,                 null: false
      t.string :procedure_image
      t.references :purpose,            foreign_key: true, null: false

      t.timestamps
    end
  end
end
