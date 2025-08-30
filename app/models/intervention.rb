# app/models/intervention.rb
class Intervention < ApplicationRecord
  # Una intervención pertenece a una moto y a un taller
  belongs_to :motorcycle
  belongs_to :workshop

  # Una intervención tiene una orden de entrada
  has_one :entry_order

  # Una intervención tiene muchas hojas de procedimientos
  has_many :procedure_sheets

  # Una intervención tiene una hoja de salida
  has_one :output_sheet

  # --- Validaciones ---
  validates :motorcycle_id, :workshop_id, presence: true
end
