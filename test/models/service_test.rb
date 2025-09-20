# test/models/service_test.rb
require "test_helper"
require "securerandom"

class ServiceTest < ActiveSupport::TestCase
  # El método setup se ejecuta antes de cada test.
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

    # Crea un taller de prueba y lo asocia al usuario
    @workshop = Workshop.create!(
      name: "Taller de Prueba #{SecureRandom.hex(4)}",
      city: "Medellín",
      user: @admin_user
    )
  end

  test "un servicio es válido con todos los atributos correctos" do
    service = Service.new(
      name: "Cambio de Aceite",
      price: 50.00,
      workshop: @workshop
    )
    assert service.valid?, "El servicio no debería ser válido: #{service.errors.full_messages}"
  end

  test "un servicio no es válido sin un nombre" do
    service = Service.new(
      price: 50.00,
      workshop: @workshop
      # Faltaría el nombre
    )
    assert_not service.valid?, "El servicio no debería ser válido sin un nombre."
    assert service.errors[:name].any?, "El error sobre el nombre no está presente."
  end
  
  test "un servicio no es válido sin un taller asociado" do
    service = Service.new(
      name: "Cambio de Aceite",
      price: 50.00
      # Faltaría el taller
    )
    assert_not service.valid?, "El servicio no debería ser válido sin un taller."
    assert service.errors[:workshop].any?, "El error sobre el taller no está presente."
  end

  test "la descripción por defecto es el nombre del servicio" do
    service = Service.new(
      name: "Cambio de Bujías",
      price: 30.00,
      workshop: @workshop
    )
    service.save
    assert_equal "Cambio de Bujías", service.description, "La descripción por defecto no es el nombre del servicio."
  end
end
