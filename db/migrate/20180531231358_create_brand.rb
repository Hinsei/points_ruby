class CreateBrand < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto'

    create_table :brands, id: :uuid do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
