# test/models/entry_order_test.rb
require "test_helper"
require "securerandom"

class EntryOrderTest < ActiveSupport::TestCase
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

    # Crea una intervención de prueba que une a la moto y el taller
    @intervention = Intervention.create!(
      motorcycle: @motorcycle,
      workshop: @workshop,
      status: 'in_progress',
      entry_date: DateTime.now
    )
  end
  
  test "una orden de entrada es válida con todos los atributos correctos" do
    entry_order = EntryOrder.new(
      problem_description: "Falla en el encendido.",
      mileage: 15000,
      intervention: @intervention,
      user: @admin_user
    )
    assert entry_order.valid?, "La orden de entrada no debería ser válida: #{entry_order.errors.full_messages}"
  end
  
  test "una orden de entrada no es válida sin un problema reportado" do
    entry_order = EntryOrder.new(
      mileage: 15000,
      intervention: @intervention,
      user: @admin_user
      # Faltaría la descripción del problema
    )
    assert_not entry_order.valid?, "La orden de entrada no debería ser válida sin una descripción del problema."
    assert entry_order.errors[:problem_description].any?, "El error sobre la descripción del problema no está presente."
  end
  
  test "una orden de entrada no es válida sin una intervención y un usuario asociado" do
    entry_order = EntryOrder.new(
      problem_description: "Falla en el encendido.",
      mileage: 15000
      # Faltarían la intervención y el usuario
    )
    assert_not entry_order.valid?, "La orden de entrada no debería ser válida sin intervención y usuario."
    assert entry_order.errors[:intervention].any?, "El error sobre la intervención no está presente."
    assert entry_order.errors[:user].any?, "El error sobre el usuario no está presente."
  end


    # test/models/entry_order_test.rb

  test "una orden de entrada puede tener fotos adjuntas" do
  # Creamos una foto de prueba en memoria
    photo = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/test/fixtures/files/test.jpg"),
      filename: "test.jpg"
    )

    entry_order = EntryOrder.new(
      problem_description: "Falla en el encendido.",
      mileage: 15000,
      intervention: @intervention,
      user: @admin_user
    )

    entry_order.photos.attach(photo)
    assert entry_order.valid?
    assert_equal 1, entry_order.photos.count
  end


end
