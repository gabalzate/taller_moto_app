# app/models/output_sheet.rb
class OutputSheet < ApplicationRecord
  # Una hoja de salida pertenece a una única intervención
  belongs_to :intervention

  # Una hoja de salida es creada por un usuario
  belongs_to :user
end
