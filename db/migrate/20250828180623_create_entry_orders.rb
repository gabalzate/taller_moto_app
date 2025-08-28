class CreateEntryOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :entry_orders do |t|
      t.text :problem_description
      t.integer :mileage
      t.integer :fuel_level
      t.integer :oil_level
      t.text :visual_inspection_chassis
      t.text :tires_condition
      t.boolean :front_light_status
      t.boolean :turn_signals_status
      t.boolean :brake_lights_status
      t.boolean :horn_status
      t.text :battery_status
      t.text :drive_chain_status
      t.text :front_brake_status
      t.text :rear_brake_status
      t.text :throttle_cable_status
      t.text :clutch_cable_status
      t.text :engine_start_status
      t.text :engine_idle_status
      t.text :engine_accelerating_status
      t.text :notes
      t.references :intervention, null: false, foreign_key: true

      t.timestamps
    end
  end
end
