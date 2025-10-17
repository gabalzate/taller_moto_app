class AddMechanicToInterventions < ActiveRecord::Migration[8.0]
  def change
    add_reference :interventions, :mechanic, null: true, foreign_key: { to_table: :users }
  end
end
