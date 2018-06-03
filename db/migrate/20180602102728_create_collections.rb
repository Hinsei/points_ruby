class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.references :customer
      t.references :brand, type: :uuid
      t.integer :collected_points, default: 0

      t.timestamps
    end

    remove_column :customers, :collected_points
  end
end
