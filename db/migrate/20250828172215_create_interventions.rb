class CreateInterventions < ActiveRecord::Migration[8.0]
  def change
    create_table :interventions do |t|
      t.datetime :entry_date
      t.datetime :output_date
      t.string :status
      t.references :motorcycle, null: false, foreign_key: true
      t.references :workshop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
