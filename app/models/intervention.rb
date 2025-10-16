# app/models/intervention.rb
class Intervention < ApplicationRecord

  # --- AÑADE ESTE BLOQUE ---  Bloque para generar tokens en cada intervención y crear enlace
  has_secure_token :public_token # Habilita la magia de Rails para generar tokens

  before_create :generate_token # Nos aseguramos de que el token se genere antes de crear el registro

  private

  def generate_token
    self.public_token = SecureRandom.hex(16) # Crea un token aleatorio de 32 caracteres
  end
  # --- FIN DEL BLOQUE ---

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
