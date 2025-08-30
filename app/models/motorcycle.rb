# app/models/motorcycle.rb
class Motorcycle < ApplicationRecord
  # Una moto pertenece a un cliente
  belongs_to :client

  # Una moto puede tener muchas intervenciones
  has_many :interventions

  # --- Validaciones ---
  validates :license_plate, presence: true, uniqueness: true
end
