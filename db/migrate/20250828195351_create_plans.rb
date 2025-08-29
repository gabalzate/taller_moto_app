class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.decimal :price, null: false
      t.integer :duration, null: false
      t.text :details

      t.timestamps
    end
  end
end
