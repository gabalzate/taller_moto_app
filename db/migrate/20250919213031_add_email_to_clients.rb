class AddEmailToClients < ActiveRecord::Migration[8.0]
  def change
    add_column :clients, :email, :string, null: false, index: { unique: true }
  end
end
