# app/controllers/public/workshops_controller.rb
class Public::WorkshopsController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'public'

  def show
    # Usamos .friendly.find para que FriendlyId busque por el slug en la URL.
    @workshop = Workshop.friendly.find(params[:id])

    # El resto de la lógica para cargar servicios y estadísticas.
    @services = @workshop.services.order(:name)
    @total_interventions = @workshop.interventions.where(status: 'Completada').count
    @top_motorcycles = @workshop.motorcycles
                                .group(:brand, :model)
                                .order('count_all DESC')
                                .limit(5)
                                .count
  end
end
