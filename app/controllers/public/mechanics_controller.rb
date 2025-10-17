# app/controllers/public/mechanics_controller.rb
class Public::MechanicsController < ApplicationController
  # Saltamos la autenticación para esta página pública.
  skip_before_action :authenticate_user!

  # Usamos el layout público.
  layout 'public'

  def show
    # Buscamos al usuario (mecánico) por su slug.
    @mechanic = User.friendly.find(params[:id])

    # --- Lógica para las Estadísticas ---

    # Contamos el total de intervenciones completadas asignadas a este mecánico.
    @total_interventions = @mechanic.assigned_interventions.where(status: 'Completada').count

    # Calculamos el top 5 de modelos de motos en los que ha trabajado.
    @top_motorcycles = Motorcycle.joins(:interventions)
                                 .where(interventions: { mechanic_id: @mechanic.id })
                                 .group(:brand, :model)
                                 .order('count_all DESC')
                                 .limit(5)
                                 .count
  end
end
