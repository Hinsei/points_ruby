class CreateCustomer < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :phone_number, null: false
      t.integer :collected_points, default: 0
      
      t.timestamps
    end
  end
end
