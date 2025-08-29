class CreateWorkshops < ActiveRecord::Migration[8.0]
  def change
    create_table :workshops do |t|
      t.string :name
      t.string :phone
      t.string :city
      t.string :address
      t.text :details
      t.string :opening_hours
      t.string :unique_profile_link
      t.boolean :status, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
