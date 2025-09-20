# test/models/conversation_test.rb
require "test_helper"
require "securerandom"

class ConversationTest < ActiveSupport::TestCase
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
  end

  test "una conversación es válida con todos los atributos correctos" do
    conversation = Conversation.new(
      user: @user,
      super_admin: @super_admin,
      status: 'open'
    )
    assert conversation.valid?, "La conversación no debería ser válida: #{conversation.errors.full_messages}"
  end
  
  test "una conversación no es válida sin un usuario y un super administrador asociados" do
    conversation = Conversation.new(
      status: 'open'
      # Faltarían el usuario y el super administrador
    )
    assert_not conversation.valid?, "La conversación no debería ser válida sin usuario y super administrador."
    assert conversation.errors[:user].any?, "El error sobre el usuario no está presente."
    assert conversation.errors[:super_admin].any?, "El error sobre el super administrador no está presente."
  end
end
