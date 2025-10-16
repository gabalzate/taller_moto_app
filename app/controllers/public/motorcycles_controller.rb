# app/controllers/public/motorcycles_controller.rb
class Public::MotorcyclesController < ApplicationController
  # Saltamos la autenticación para todas las acciones de este controlador
  skip_before_action :authenticate_user!

  # Usamos el layout público que ya creamos
  layout 'public'

  # Acción para mostrar el formulario de búsqueda
  def search
  end

  # Acción para buscar la moto y mostrar su historial
  def result
    # Recibimos los parámetros de la URL (del formulario de búsqueda)
    license_plate = params[:license_plate].upcase.strip # Normalizamos la placa a mayúsculas y sin espacios
    document_number = params[:document_number].strip

    # Buscamos la motocicleta por su placa
    @motorcycle = Motorcycle.find_by(license_plate: license_plate)

    # Verificamos si la moto existe Y si el número de documento del propietario coincide
    if @motorcycle && @motorcycle.client.document_number == document_number
      # Si todo es correcto, cargamos todas sus intervenciones en orden descendente
      @interventions = @motorcycle.interventions.includes(:workshop, :entry_order).order(entry_date: :desc)
    else
      # Si la moto no existe o el documento no coincide, redirigimos de vuelta al formulario con un error
      redirect_to public_motorcycle_history_search_path, alert: "No se encontraron registros. Por favor, verifica que la placa y el número de documento sean correctos."
    end
  end
end
