# test/models/intervention_test.rb
require "test_helper"
require "securerandom"

class InterventionTest < ActiveSupport::TestCase
  # El método setup se ejecuta antes de cada test.
  def setup
    # Crea un usuario administrador y un taller de prueba
    @admin_user = User.create!(
      first_name: "Test",
      last_name: "Admin",
      email: "admin_#{SecureRandom.hex(4)}@example.com",
      document_number: SecureRandom.hex(8),
      phone_number: "555-1111",
      is_admin: true
    )

    @workshop = Workshop.create!(
      name: "Taller de Prueba #{SecureRandom.hex(4)}",
      city: "Medellín",
      user: @admin_user
    )

    # Crea un cliente de prueba asociado al taller y al usuario
    @client = Client.create!(
      name: "Cliente de Prueba",
      document_number: SecureRandom.hex(8),
      email: "cliente_#{SecureRandom.hex(4)}@example.com",
      phone_number: "3001234567",
      workshop: @workshop,
      user: @admin_user
    )

    # Crea una motocicleta de prueba asociada al cliente
    @motorcycle = Motorcycle.create!(
      license_plate: "ABC-123-#{SecureRandom.hex(4)}",
      brand: "Honda",
      model: "CBR",
      year: 2020,
      client: @client
    )
  end
  
  test "una intervención es válida con todos los atributos correctos" do
    intervention = Intervention.new(
      motorcycle: @motorcycle,
      workshop: @workshop,
      status: 'in_progress',
      entry_date: DateTime.now
    )
    assert intervention.valid?, "La intervención no debería ser válida: #{intervention.errors.full_messages}"
  end
  
  test "una intervención no es válida sin una moto y un taller asociado" do
    intervention = Intervention.new(
      status: 'in_progress',
      entry_date: DateTime.now
      # Faltarían la moto y el taller
    )
    assert_not intervention.valid?, "La intervención no debería ser válida sin moto y taller."
    assert intervention.errors[:motorcycle].any?, "El error sobre la moto no está presente."
    assert intervention.errors[:workshop].any?, "El error sobre el taller no está presente."
  end
end
