# app/controllers/motorcycles_controller.rb
class MotorcyclesController < ApplicationController
  # Esto asegura que solo los usuarios autenticados puedan acceder a las acciones
  before_action :authenticate_user!
  # Esto aplica las reglas de CanCanCan y automáticamente busca la moto por su ID
  load_and_authorize_resource
  skip_load_and_authorize_resource only: [:create_intervention]

  def index
    @motorcycles = Motorcycle.all
  end

  def show
    @motorcycle = Motorcycle.find(params[:id])
  end
  

  def create_intervention
    @motorcycle = Motorcycle.find(params[:id])

    # Creamos la nueva intervención en memoria y le asignamos un estado y fecha de entrada.
    @intervention = @motorcycle.interventions.new(
      workshop: current_user.workshop, 
      status: 'En Progreso', 
      entry_date: Time.current
    )

    # --- LÍNEA AÑADIDA ---
    # Le decimos explícitamente a CanCanCan que verifique si el usuario
    # tiene permiso para :create sobre el nuevo objeto @intervention.
    # La regla en ability.rb (can :manage, Intervention) permitirá que esto pase.
    authorize! :create, @intervention
    # --- FIN DE LA LÍNEA AÑADIDA ---

    if @intervention.save
      redirect_to new_intervention_entry_order_path(@intervention), notice: "Intervención iniciada con éxito. Por favor, complete la orden de entrada."
    else
      redirect_to @motorcycle, alert: "No se pudo iniciar la intervención."
    end
  end


  def new
    @motorcycle = Motorcycle.new
    # --- LÍNEA AÑADIDA ---
    # Cargamos solo los clientes del taller del usuario actual para el formulario.
    # Esto asegura que no pueda asignarle una moto a un cliente de otro taller.
    @clients = current_user.workshop.clients
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
