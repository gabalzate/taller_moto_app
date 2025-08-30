# app/models/workshop.rb
class Workshop < ApplicationRecord
  # Un taller pertenece a un usuario (el administrador)
  belongs_to :user

  # Un taller tiene muchos usuarios (los mecánicos)
  has_many :users
  
  # Un taller tiene muchos clientes
  has_many :clients

  # Un taller tiene muchos servicios
  has_many :services

  # Un taller tiene muchas intervenciones
  has_many :interventions

  # Un taller tiene muchas motocicletas a través de las intervenciones
  has_many :motorcycles, through: :interventions

  # --- Validaciones ---
  validates :name, presence: true, uniqueness: true
  validates :city, presence: true
end
