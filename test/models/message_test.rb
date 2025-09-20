# test/models/message_test.rb
require "test_helper"
require "securerandom"

class MessageTest < ActiveSupport::TestCase
  # El método setup se ejecuta antes de cada test.
  def setup
    # Crea un usuario de prueba
    @user = User.create!(
      first_name: "Test",
      last_name: "User",
      email: "user_#{SecureRandom.hex(4)}@example.com",
      document_number: SecureRandom.hex(8),
      phone_number: "555-1111",
      is_admin: true
    )

    # Crea un super administrador de prueba
    @super_admin = User.create!(
      first_name: "Super",
      last_name: "Admin",
      email: "super_admin_#{SecureRandom.hex(4)}@example.com",
      document_number: SecureRandom.hex(8),
      phone_number: "555-2222",
      is_super_admin: true
    )
    
    # Crea una conversación de prueba que une al usuario y al super administrador
    @conversation = Conversation.create!(
      user: @user,
      super_admin: @super_admin,
      status: 'open'
    )
  end

  test "un mensaje es válido con todos los atributos correctos" do
    message = Message.new(
      conversation: @conversation,
      sender: @user,
      content: "Hola, tengo una pregunta sobre el taller."
    )
    assert message.valid?, "El mensaje no debería ser válido: #{message.errors.full_messages}"
  end
  
  test "un mensaje no es válido sin contenido" do
    message = Message.new(
      conversation: @conversation,
      sender: @user
      # Faltaría el contenido
    )
    assert_not message.valid?, "El mensaje no debería ser válido sin contenido."
    assert message.errors[:content].any?, "El error sobre el contenido no está presente."
  end
  
  test "un mensaje no es válido sin una conversación y un emisor asociados" do
    message = Message.new(
      content: "Hola, tengo una pregunta sobre el taller."
      # Faltarían la conversación y el emisor
    )
    assert_not message.valid?, "El mensaje no debería ser válido sin conversación y emisor."
    assert message.errors[:conversation].any?, "El error sobre la conversación no está presente."
    assert message.errors[:sender].any?, "El error sobre el emisor no está presente."
  end
end
