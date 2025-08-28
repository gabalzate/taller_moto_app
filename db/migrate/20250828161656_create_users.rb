class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :document_number
      t.string :phone_number
      t.string :role
      t.boolean :status
      t.references :workshop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
