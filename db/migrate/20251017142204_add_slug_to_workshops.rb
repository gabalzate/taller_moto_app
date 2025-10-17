class AddSlugToWorkshops < ActiveRecord::Migration[8.0]
  def change
    add_column :workshops, :slug, :string
    add_index :workshops, :slug, unique: true
  end
end
