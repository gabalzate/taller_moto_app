# test/models/client_test.rb
require "test_helper"
require "securerandom"

class ClientTest < ActiveSupport::TestCase
  # Método que se ejecuta antes de cada test para crear los datos de prueba
  def setup
    # Crea un usuario administrador con un email y documento únicos
    @admin_user = User.create!(
      first_name: "Test",
      last_name: "Admin",
      email: "admin_#{SecureRandom.hex(4)}@example.com",
      document_number: SecureRandom.hex(8),
      phone_number: "555-1111",
      is_admin: true
    )

    # Crea un taller de prueba con un nombre único y lo asocia al usuario
    @workshop = Workshop.create!(
      name: "Taller de Prueba #{SecureRandom.hex(4)}",
      city: "Medellín",
      user: @admin_user
    )

    # Crea un cliente de prueba con un documento y email únicos, y lo asocia al taller y al usuario
    @client = Client.create!(
      name: "Cliente de Prueba",
      document_number: SecureRandom.hex(8),
      email: "cliente_#{SecureRandom.hex(4)}@example.com",
      phone_number: "3001234567",
      workshop: @workshop,
      user: @admin_user
    )
  end

  test "un cliente es válido con todos los atributos correctos" do
    client = Client.new(
      name: "Cliente de Prueba",
      document_number: "11111111",
      phone_number: "3001234567",
      workshop: @workshop,
      user: @admin_user,
      email: "otro_cliente@example.com"
    )
    assert client.valid?, "El cliente no debería ser válido: #{client.errors.full_messages}"
  end

  test "el número de documento del cliente debe ser único" do
    # Creamos un primer cliente para que exista en la base de datos
    documento_de_prueba = SecureRandom.hex(8)
    Client.create!(
      name: "Cliente Uno",
      document_number: documento_de_prueba,
      phone_number: "555-2222",
      workshop: @workshop,
      user: @admin_user,
      email: "cliente_uno@example.com"
    )

    # Intenta crear un segundo cliente con el mismo documento
    duplicate_client = Client.new(
      name: "Cliente Duplicado",
      document_number: documento_de_prueba,
      phone_number: "555-3333",
      workshop: @workshop,
      user: @admin_user,
      email: "cliente_duplicado@example.com"
    )
    assert_not duplicate_client.valid?, "El número de documento debería ser único."
  end

  test "un cliente no es válido sin un taller y un usuario asociado" do
    client = Client.new(
      name: "Cliente Sin Taller",
      document_number: "88888888",
      phone_number: "555-4444",
      email: "cliente_sin_taller@example.com"
      # Faltaría el taller y el usuario
    )
    assert_not client.valid?, "El cliente no debería ser válido sin taller y usuario."
    assert client.errors[:workshop].any?, "El error sobre el taller no está presente."
    assert client.errors[:user].any?, "El error sobre el usuario no está presente."
  end
end
