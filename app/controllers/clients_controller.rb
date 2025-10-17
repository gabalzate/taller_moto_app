# app/controllers/clients_controller.rb
class ClientsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.user = current_user
    # Verificamos el rol del usuario para encontrar el taller correcto.
    if current_user.is_admin?
      # Si es admin, usamos la relación 'workshop' (has_one).
      @client.workshop = current_user.workshop 
    elsif current_user.is_mechanic?
      # Si es mecánico, usamos la relación 'workplace' (belongs_to).
      @client.workshop = current_user.workplace
    end
    

    if @client.save
      redirect_to @client, notice: 'Cliente creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Cliente actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Cliente eliminado exitosamente.'
  end

  private

  def client_params
    params.require(:client).permit(:name, :email, :document_number, :phone_number, :workshop_id)
  end
end
