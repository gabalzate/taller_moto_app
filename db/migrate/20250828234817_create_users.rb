class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :document_number
      t.string :phone_number
      t.boolean :is_super_admin, default: false
      t.boolean :is_admin, default: false
      t.boolean :is_mechanic, default: false
      t.boolean :status, default: true
      t.references :workshop, foreign_key: true

      t.timestamps
    end
  end
end

