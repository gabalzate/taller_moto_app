# app/controllers/procedure_sheets_controller.rb
class ProcedureSheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_intervention
  load_and_authorize_resource :intervention
  load_and_authorize_resource :procedure_sheet, through: :intervention

  def new
    @procedure_sheet = @intervention.procedure_sheets.new
  end

  def create
    @procedure_sheet = @intervention.procedure_sheets.new(procedure_sheet_params)
    @procedure_sheet.user = current_user
    if @procedure_sheet.save
      redirect_to intervention_path(@intervention), notice: 'Hoja de procedimientos creada exitosamente.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @procedure_sheet.update(procedure_sheet_params)
      redirect_to intervention_path(@intervention), notice: 'Hoja de procedimientos actualizada exitosamente.'
    else
      render :edit
    end
  end

  private

  def set_intervention
    @intervention = Intervention.find(params[:intervention_id])
  end

  def procedure_sheet_params
    params.require(:procedure_sheet).permit(:content, photos: [])
  end
end
