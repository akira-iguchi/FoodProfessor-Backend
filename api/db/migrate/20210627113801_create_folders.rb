class CreateFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :folders do |t|
      t.string :folder_name,    null: false
      t.references :user,       foreign_key: true, null: false

      t.timestamps
    end
  end
end
