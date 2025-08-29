# app/models/service.rb
class Service < ApplicationRecord
  # Un servicio pertenece a un taller
  belongs_to :workshop

  # Este callback se ejecuta antes de que el servicio se guarde en la base de datos.
  before_save :set_default_description

  private

  # Método privado para establecer la descripción por defecto
  def set_default_description
    # Si la descripción está en blanco (nil o string vacío), le asignamos el valor del nombre del servicio.
    self.description = self.name if self.description.blank?
  end
end
