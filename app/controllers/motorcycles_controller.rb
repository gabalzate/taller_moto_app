# app/controllers/motorcycles_controller.rb
class MotorcyclesController < ApplicationController
  # Esto asegura que solo los usuarios autenticados puedan acceder a las acciones
  before_action :authenticate_user!
  # Esto aplica las reglas de CanCanCan y automáticamente busca la moto por su ID
  load_and_authorize_resource

  def index
    @motorcycles = Motorcycle.all
  end

  def show
    @motorcycle = Motorcycle.find(params[:id])
  end

  def create_intervention
    @motorcycle = Motorcycle.find(params[:id])
    @intervention = @motorcycle.interventions.new(workshop: current_user.workshop)
    if @intervention.save
      redirect_to new_intervention_entry_order_path(@intervention), notice: "Intervención iniciada con éxito. Por favor, complete la orden de entrada."
    else
      redirect_to @motorcycle, alert: "No se pudo iniciar la intervención."
    end
  end


  def new
    @motorcycle = Motorcycle.new
  end

  def create
    @motorcycle = Motorcycle.new(motorcycle_params)
    if @motorcycle.save
      redirect_to @motorcycle, notice: 'Motocicleta creada exitosamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @motorcycle.update(motorcycle_params)
      redirect_to @motorcycle, notice: 'Motocicleta actualizada exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @motorcycle.destroy
    redirect_to motorcycles_url, notice: 'Motocicleta eliminada exitosamente.'
  end

  private

  def motorcycle_params
    params.require(:motorcycle).permit(:license_plate, :brand, :model, :year, :client_id)
  end
end
