# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.sender = current_user
    authorize! :create, @message

    if @message.save
      # Esto buscará una vista create.turbo_stream.erb para la actualización en tiempo real
    else
      # Manejar el error, por ejemplo, renderizando el formulario de nuevo con errores.
      # Por simplicidad, por ahora no haremos nada aquí.
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
