# app/controllers/conversations_controller.rb
class ConversationsController < ApplicationController
  before_action :authenticate_user!
  # Esta línea ahora se encargará de cargar y autorizar los recursos automáticamente
  load_and_authorize_resource 
  before_action :set_super_admin, only: [:create]

  def index
    # @conversations es cargado y filtrado automáticamente por CanCanCan
    # basándose en las reglas de ability.rb
  end

  def show
    # @conversation es cargado automáticamente por CanCanCan
    @messages = @conversation.messages.order(created_at: :asc)
    @message = @conversation.messages.new
  end

  def create
    # Evita crear conversaciones duplicadas
    @conversation = current_user.conversations.first_or_create!(super_admin: @super_admin)
    redirect_to @conversation, notice: "Chat iniciado."
  end

  private

  def set_super_admin
    @super_admin = User.find_by(is_super_admin: true)
    unless @super_admin
      redirect_to root_path, alert: "No se encontró un super administrador para iniciar el chat."
    end
  end
end
