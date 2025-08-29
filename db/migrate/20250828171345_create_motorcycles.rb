class CreateMotorcycles < ActiveRecord::Migration[8.0]
  def change
    create_table :motorcycles do |t|
      t.string :license_plate
      t.string :brand
      t.string :model
      t.integer :year
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end

