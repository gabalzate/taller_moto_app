# app/controllers/public/interventions_controller.rb
class Public::InterventionsController < ApplicationController
  # Saltamos la autenticación de Devise para esta página pública
  skip_before_action :authenticate_user!, only: [:show]

  # Usamos un layout más simple para la vista pública
  layout 'public'

  def show
    # Buscamos la intervención usando el token de la URL
    @intervention = Intervention.find_by!(public_token: params[:token])

    # Cargamos los datos asociados para mostrarlos en la vista
    @entry_order = @intervention.entry_order
    @procedure_sheets = @intervention.procedure_sheets.order(created_at: :asc)
    @output_sheet = @intervention.output_sheet
  end
end
