class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.string :title
      t.string :description
      t.integer :cost
      t.references :brand, type: :uuid

      t.timestamps
    end
  end
end
