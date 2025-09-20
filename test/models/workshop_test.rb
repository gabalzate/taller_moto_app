# test/models/workshop_test.rb
require "test_helper"
require "securerandom"

class WorkshopTest < ActiveSupport::TestCase
  # Método que se ejecuta antes de cada test para crear los datos de prueba
  def setup
    @admin_user = User.create!(
      first_name: "Test",
      last_name: "Admin",
      email: "admin_#{SecureRandom.hex(4)}@example.com",
      document_number: SecureRandom.hex(8),
      phone_number: "555-1111",
      is_admin: true
    )
  end

  test "un taller es válido con todos los atributos correctos" do
    workshop = Workshop.new(
      name: "Taller de Prueba",
      city: "Medellín",
      user: @admin_user
    )
    assert workshop.valid?, "El taller no debería ser válido: #{workshop.errors.full_messages}"
  end
  
  test "el nombre del taller debe ser único" do
    # Crea un primer taller para que exista en la base de datos
    Workshop.create!(
      name: "Taller Único",
      city: "Cali",
      user: @admin_user
    )
    
    # Intenta crear un segundo taller con el mismo nombre, lo que debe fallar.
    duplicate_workshop = Workshop.new(
      name: "Taller Único",
      city: "Bogotá",
      user: @admin_user
    )
    assert_not duplicate_workshop.valid?, "El nombre del taller debería ser único."
  end
  
  test "un taller no es válido sin un usuario administrador" do
    workshop = Workshop.new(
      name: "Taller Sin Dueño",
      city: "Medellín"
      # Faltaría el usuario
    )
    assert_not workshop.valid?, "El taller no debería ser válido sin un usuario."
    assert workshop.errors[:user].any?, "El error sobre el usuario no está presente."
  end
end
