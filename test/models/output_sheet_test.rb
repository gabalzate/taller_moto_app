# test/models/output_sheet_test.rb
require "test_helper"
require "securerandom"

class OutputSheetTest < ActiveSupport::TestCase
  # El método setup se ejecuta antes de cada test.
  def setup
    # Crea un usuario mecánico con un email y documento únicos
    @mechanic_user = User.create!(
      first_name: "Test",
      last_name: "Mecánico",
      email: "mechanic_#{SecureRandom.hex(4)}@example.com",
      document_number: SecureRandom.hex(8),
      phone_number: "555-2222",
      is_mechanic: true
    )

    # Crea un taller de prueba y lo asocia al usuario
    @workshop = Workshop.create!(
      name: "Taller de Prueba #{SecureRandom.hex(4)}",
      city: "Medellín",
      user: User.create!(first_name: "Admin", email: "admin_#{SecureRandom.hex(4)}@example.com", document_number: SecureRandom.hex(8), is_admin: true)
    )

    # Crea un cliente de prueba asociado al taller y al usuario
    @client = Client.create!(
      name: "Cliente de Prueba",
      document_number: SecureRandom.hex(8),
      email: "cliente_#{SecureRandom.hex(4)}@example.com",
      phone_number: "3001234567",
      workshop: @workshop,
      user: @mechanic_user
    )

    # Crea una motocicleta de prueba asociada al cliente
    @motorcycle = Motorcycle.create!(
      license_plate: "ABC-123-#{SecureRandom.hex(4)}",
      brand: "Honda",
      model: "CBR",
      year: 2020,
      client: @client
    )

    # Crea una intervención de prueba que une a la moto y el taller
    @intervention = Intervention.create!(
      motorcycle: @motorcycle,
      workshop: @workshop,
      status: 'in_progress',
      entry_date: DateTime.now
    )
  end
  
  test "una hoja de salida es válida con todos los atributos correctos" do
    output_sheet = OutputSheet.new(
      mileage: 15000,
      notes: "Servicio completo",
      intervention: @intervention,
      user: @mechanic_user
    )
    assert output_sheet.valid?, "La hoja de salida no debería ser válida: #{output_sheet.errors.full_messages}"
  end
  
  test "una hoja de salida no es válida sin un kilometraje" do
    output_sheet = OutputSheet.new(
      notes: "Servicio completo",
      intervention: @intervention,
      user: @mechanic_user
      # Faltaría el kilometraje
    )
    assert_not output_sheet.valid?, "La hoja de salida no debería ser válida sin un kilometraje."
    assert output_sheet.errors[:mileage].any?, "El error sobre el kilometraje no está presente."
  end
  
  test "una hoja de salida no es válida sin una intervención y un usuario asociado" do
    output_sheet = OutputSheet.new(
      mileage: 15000,
      notes: "Servicio completo"
      # Faltarían la intervención y el usuario
    )
    assert_not output_sheet.valid?, "La hoja de salida no debería ser válida sin intervención y usuario."
    assert output_sheet.errors[:intervention].any?, "El error sobre la intervención no está presente."
    assert output_sheet.errors[:user].any?, "El error sobre el usuario no está presente."
  end
end
