class CreateConversations < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :super_admin, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
