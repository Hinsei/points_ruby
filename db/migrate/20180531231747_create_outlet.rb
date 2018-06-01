class CreateOutlet < ActiveRecord::Migration[5.2]
  def change
    create_table :outlets do |t|
      t.string :name, null: false
      t.string :password_digest
      t.references :brand, type: :uuid

      t.timestamps 
    end
  end
end
