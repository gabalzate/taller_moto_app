# app/controllers/clients_controller.rb
class ClientsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @clients = Client.all
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.user = current_user
    @client.workshop = current_user.workshops.first # Asume que un admin tiene al menos un taller
    if @client.save
      redirect_to @client, notice: 'Cliente creado exitosamente.'
    else
      render :new
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
