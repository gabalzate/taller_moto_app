# app/models/client.rb
class Client < ApplicationRecord
  # Un cliente pertenece a un taller
  belongs_to :workshop

  # Un cliente puede tener muchas motos
  has_many :motorcycles

  # Un cliente puede ver el historial de intervenciones de sus motos
  has_many :interventions, through: :motorcycles
  # Un cliente es creado por un usuario (mecánico o administrador)
  belongs_to :user

  # --- Validaciones ---
  validates :name, :document_number, :phone_number, presence: true
  validates :document_number, uniqueness: true
  validates :email, uniqueness: { allow_blank: true }, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }
end
