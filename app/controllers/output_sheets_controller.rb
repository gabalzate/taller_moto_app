# app/controllers/output_sheets_controller.rb
class OutputSheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_intervention

  # Carga y autoriza la intervención padre
  load_and_authorize_resource :intervention
  # Carga y autoriza la hoja de salida a través de la intervención
  # Usamos singleton: true porque es una relación has_one
  load_and_authorize_resource :output_sheet, through: :intervention, singleton: true

  def new
    # El método build_output_sheet es para relaciones has_one
    @output_sheet = @intervention.build_output_sheet
  end

  def create
    @output_sheet = @intervention.build_output_sheet(output_sheet_params)
    @output_sheet.user = current_user

    if @output_sheet.save
      # Actualizamos la intervención para marcarla como completada
      @intervention.update(status: 'Completada', output_date: Time.current)
      redirect_to intervention_path(@intervention), notice: 'Hoja de Salida creada exitosamente. La intervención ha sido completada.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @output_sheet es cargado por load_and_authorize_resource
  end

  def edit
    # @output_sheet es cargado por load_and_authorize_resource
  end

  def update
    if @output_sheet.update(output_sheet_params)
      redirect_to intervention_path(@intervention), notice: 'Hoja de Salida actualizada exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_intervention
    @intervention = Intervention.find(params[:intervention_id])
  end

  def output_sheet_params
    params.require(:output_sheet).permit(
      :mileage, :fuel_level, :oil_level, :notes, :repaired_parts, :disclaimer
    )
  end
end
