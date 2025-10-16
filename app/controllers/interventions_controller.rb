## app/controllers/interventions_controller.rb
class InterventionsController < ApplicationController
  before_action :set_intervention, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def show
    @entry_order = @intervention.entry_order
    @procedure_sheets = @intervention.procedure_sheets.order(created_at: :desc) # Ordenamos para ver el más reciente primero
    @output_sheet = @intervention.output_sheet 
    authorize! :read, @intervention
  end


  def index

    # Verificamos si se envió un parámetro de búsqueda llamado 'query'.
    if params[:query].present?
      # Si hay una búsqueda, filtramos la colección @interventions.
      # Usamos 'joins' para poder buscar en las tablas de motocicletas y clientes.
      @interventions = @interventions.joins(motorcycle: :client)
                                   .where("motorcycles.license_plate LIKE ? OR clients.document_number LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end
  end


  def new
    @intervention = Intervention.new
  end

  def create
    @intervention = Intervention.new(intervention_params)
    if @intervention.save
      redirect_to @intervention, notice: 'Intervención creada exitosamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @intervention.update(intervention_params)
      redirect_to @intervention, notice: 'Intervención actualizada exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @intervention.destroy
    redirect_to interventions_url, notice: 'Intervención eliminada exitosamente.'
  end


  private

  def set_intervention
    @intervention = Intervention.find(params[:id])
  end

  def intervention_params
    params.require(:intervention).permit(:motorcycle_id, :workshop_id, :status, :entry_date, :output_date)
  end
end
