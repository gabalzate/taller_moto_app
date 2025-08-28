class CreateClients < ActiveRecord::Migration[8.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :document_number
      t.string :phone_number
      t.references :workshop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
