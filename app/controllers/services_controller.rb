# app/controllers/services_controller.rb
class ServicesController < ApplicationController
  before_action :authenticate_user!
  # Carga el taller del administrador actual antes de cada acción.
  before_action :set_workshop

  # Muestra la lista de servicios del taller.
  def index
    @services = @workshop.services
    authorize! :read, Service
  end

  # Prepara un nuevo servicio para el formulario.
  def new
    @service = @workshop.services.new
    authorize! :create, @service
  end

  # Crea y guarda el nuevo servicio en la base de datos.
  def create
    @service = @workshop.services.new(service_params)
    authorize! :create, @service

    if @service.save
      redirect_to workshop_services_path(@workshop), notice: 'Servicio añadido exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Prepara el formulario para editar un servicio existente.
  def edit
    @service = @workshop.services.find(params[:id])
    authorize! :update, @service
  end

  # Procesa los cambios del formulario de edición.
  def update
    @service = @workshop.services.find(params[:id])
    authorize! :update, @service

    if @service.update(service_params)
      redirect_to workshop_services_path(@workshop), notice: 'Servicio actualizado exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Elimina un servicio de la base de datos.
  def destroy
    @service = @workshop.services.find(params[:id])
    authorize! :destroy, @service

    @service.destroy
    redirect_to workshop_services_path(@workshop), notice: 'Servicio eliminado exitosamente.'
  end

  private

  def set_workshop
    # Busca el taller que le pertenece al administrador actual.
    @workshop = current_user.workshop
    redirect_to root_path, alert: "No se encontró tu taller." unless @workshop
  end

  def service_params
    # Define los campos permitidos para crear/actualizar un servicio.
    params.require(:service).permit(:name, :description, :price)
  end
end
