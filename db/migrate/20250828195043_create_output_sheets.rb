class CreateOutputSheets < ActiveRecord::Migration[8.0]
  def change
    create_table :output_sheets do |t|
      t.integer :mileage
      t.integer :fuel_level
      t.integer :oil_level
      t.text :notes
      t.text :repaired_parts
      t.text :disclaimer
      t.references :intervention, null: false, foreign_key: true

      t.timestamps
    end
  end
end
