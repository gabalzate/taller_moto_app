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

    # --- LÓGICA CORREGIDA Y MÁS ROBUSTA ---
    # Primero, determinamos cuál es el taller correcto según el rol del usuario.
    target_workshop = if current_user.is_admin?
                        current_user.workshop
                      elsif current_user.is_mechanic?
                        current_user.workplace
                      end

      # Si por alguna razón no se encuentra un taller, detenemos el proceso.
    unless target_workshop
      redirect_to @motorcycle, alert: "No se pudo determinar el taller para iniciar la intervención."
      return
    end
    # --- FIN DE LA CORRECCIÓN ---

    # Creamos la nueva intervención usando el taller correcto que encontramos.
    @intervention = @motorcycle.interventions.new(
      workshop: target_workshop,
      status: 'En Progreso',
      entry_date: Time.current
    )

    # Ahora, la autorización SÍ funcionará porque @intervention tendrá el workshop_id correcto.
    authorize! :create, @intervention

    if @intervention.save
      redirect_to new_intervention_entry_order_path(@intervention), notice: "Intervención iniciada con éxito. Por favor, complete la orden de entrada."
    else
      redirect_to @motorcycle, alert: "No se pudo iniciar la intervención. #{@intervention.errors.full_messages.to_sentence}"
    end
  end



  def new
    @motorcycle = Motorcycle.new

    # --- LÓGICA CORREGIDA PARA AMBOS ROLES ---
    # Verificamos el rol del usuario para encontrar la lista de clientes correcta.
    if current_user.is_admin?
      # Si es admin, busca clientes a través de su 'workshop'.
      @clients = current_user.workshop.clients
    elsif current_user.is_mechanic?
      # Si es mecánico, busca clientes a través de su 'workplace'.
      @clients = current_user.workplace.clients
    else
      # Si no es ninguno, la lista estará vacía por seguridad.
      @clients = []
    end
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
