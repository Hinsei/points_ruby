class CreateRedemptions < ActiveRecord::Migration[5.2]
  def change
    create_table :redemptions do |t|
      t.references :outlet
      t.references :promotion
      t.references :customer

      t.timestamps
    end
  end
end
