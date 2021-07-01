class CreatePurposes < ActiveRecord::Migration[6.1]
  def change
    create_table :purposes do |t|
      t.string :purpose_name,           null: false
      t.text :purpose_content
      t.integer :purpose_for_people,    default: 1
      t.integer :purpose_time
      t.references :recipe,             foreign_key: true, null: false

      t.timestamps
    end
  end
end
