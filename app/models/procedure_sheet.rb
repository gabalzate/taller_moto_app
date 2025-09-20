# app/models/procedure_sheet.rb
class ProcedureSheet < ApplicationRecord
  # Una hoja de procedimientos pertenece a una única intervención
  belongs_to :intervention

  # Una hoja de procedimientos pertenece a un único usuario (mecánico)
  belongs_to :user

  # ... otras relaciones ...
  has_many_attached :photos

  # --- Validaciones ---
  validates :content, presence: true
end
