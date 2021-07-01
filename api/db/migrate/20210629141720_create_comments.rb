class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :comment_content,       null: false
      t.string :comment_image
      t.references :user,            foreign_key: true, null: false
      t.references :recipe,          foreign_key: true, null: false

      t.timestamps
    end
  end
end
