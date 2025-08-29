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
end
