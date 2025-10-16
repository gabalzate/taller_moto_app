# app/controllers/workshops_controller.rb
class WorkshopsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # Este 'before_action' se asegura de que nadie pueda acceder a las páginas 'new' o 'create'
  # si ya tienen un taller registrado.
  before_action :check_for_existing_workshop, only: [:new, :create]

  # La acción 'index' ahora te redirigirá a tu taller si ya existe.
  def index
    @workshop = current_user.workshop
    if @workshop
      redirect_to @workshop
    else
      # Si no tiene taller, lo enviamos a crearlo.
      redirect_to new_workshop_path, notice: "Primero debes registrar tu taller."
    end
  end

  def show
    # CanCanCan carga @workshop automáticamente.
  end

  def new
    # CanCanCan carga @workshop automáticamente.
  end

  def create
    @workshop = Workshop.new(workshop_params)
    @workshop.user = current_user
    if @workshop.save
      # Al crearlo exitosamente, lo redirigimos al dashboard que ahora mostrará la información.
      redirect_to root_path, notice: '¡Taller creado exitosamente!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # CanCanCan carga @workshop automáticamente.
  end

  def update
    if @workshop.update(workshop_params)
      redirect_to @workshop, notice: 'Taller actualizado exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workshop.destroy
    # Al eliminarlo, lo redirigimos al dashboard para que pueda crear uno nuevo.
    redirect_to root_path, notice: 'Taller eliminado exitosamente.'
  end

  private

  def workshop_params
    params.require(:workshop).permit(:name, :phone, :city, :address, :details, :opening_hours, :unique_profile_link, :status)
  end

  # Este método privado protege las rutas de creación.
  def check_for_existing_workshop
    if current_user.workshop.present?
      redirect_to root_path, alert: "Ya tienes un taller registrado. No puedes crear más de uno."
    end
  end
end
