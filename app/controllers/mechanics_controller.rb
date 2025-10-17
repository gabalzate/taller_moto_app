# app/controllers/mechanics_controller.rb
class MechanicsController < ApplicationController
  before_action :authenticate_user!
  # Carga el taller del administrador actual antes de cada acción.
  before_action :set_workshop

  # Muestra la lista de mecánicos del taller.
  def index
    # Buscamos solo los usuarios que son mecánicos y pertenecen al taller del admin.
    @mechanics = @workshop.users.where(is_mechanic: true)
    # Autoriza que el admin pueda leer la lista de mecánicos de su taller.
    authorize! :read, User
  end

  # Prepara un nuevo usuario (mecánico) para el formulario.
  def new
    # Creamos un nuevo usuario y le asignamos el rol de mecánico desde el principio.
    @mechanic = @workshop.users.new(is_mechanic: true)
    authorize! :create, @mechanic
  end


  # Crea y guarda el nuevo mecánico en la base de datos.
  def create
    @mechanic = @workshop.users.new(mechanic_params)
    @mechanic.is_mechanic = true
    # Asignamos el rol de mecánico explícitamente.

    if @mechanic.save
      redirect_to workshop_mechanics_path(@workshop), notice: 'Mecánico añadido exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

 
  def show
    # Usamos '.friendly.find' para buscar por slug (texto) o por ID.
    @mechanic = @workshop.users.friendly.find(params[:id])
    authorize! :read, @mechanic
  end

  def edit
    @mechanic = @workshop.users.friendly.find(params[:id])
    authorize! :update, @mechanic
  end

  def update
    @mechanic = @workshop.users.friendly.find(params[:id])
    authorize! :update, @mechanic

    if @mechanic.update(mechanic_params)
      redirect_to workshop_mechanics_path(@workshop), notice: 'Mecánico actualizado exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @mechanic = @workshop.users.friendly.find(params[:id])
    authorize! :destroy, @mechanic
    
    @mechanic.destroy
    redirect_to workshop_mechanics_path(@workshop), notice: 'Mecánico eliminado exitosamente.'
  end




  private

  def set_workshop
    # Busca el taller que le pertenece al administrador actual.
    @workshop = current_user.workshop
    # Si no encuentra un taller, redirige con una alerta.
    redirect_to root_path, alert: "No se encontró tu taller." unless @workshop
  end

  def mechanic_params
    # Define los campos permitidos para crear/actualizar un mecánico.
    params.require(:user).permit(:first_name, :last_name, :email, :document_number, :phone_number, :password, :password_confirmation)
  end
end
