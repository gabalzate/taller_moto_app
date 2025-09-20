class AddUserToOutputSheets < ActiveRecord::Migration[8.0]
  def change
    add_reference :output_sheets, :user, null: false, foreign_key: true
  end
end
