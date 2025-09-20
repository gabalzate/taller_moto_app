# test/models/motorcycle_test.rb
require "test_helper"
require "securerandom"

class MotorcycleTest < ActiveSupport::TestCase
  # El método setup se ejecuta antes de cada test.
  def setup
    # Crea un usuario administrador con un email y documento únicos
    @admin_user = User.create!(
      first_name: "Test",
      last_name: "Admin",
      email: "test_admin_#{SecureRandom.hex(4)}@example.com",
      document_number: SecureRandom.hex(8),
      phone_number: "555-1234",
      is_admin: true
    )

    # Crea un taller de prueba con un nombre único y lo asocia al usuario
    @workshop = Workshop.create!(
      name: "Taller de Prueba #{SecureRandom.hex(4)}",
      city: "Bogota",
      user: @admin_user
    )
    
    # Crea un cliente de prueba con un documento y email únicos, y lo asocia al taller y al usuario
    @client = Client.create!(
      name: "Test Client",
      document_number: SecureRandom.hex(8),
      email: "client_#{SecureRandom.hex(4)}@example.com",
      phone_number: "555-1234",
      workshop: @workshop,
      user: @admin_user
    )
  end

  test "la moto es válida con todos los atributos correctos" do
    motorcycle = Motorcycle.new(
      license_plate: "ABC-123-#{SecureRandom.hex(4)}",
      brand: "Honda",
      model: "CBR",
      year: 2020,
      client: @client
    )
    assert motorcycle.valid?, "La moto no debería ser válida: #{motorcycle.errors.full_messages}"
  end
  
    test "la placa de la moto debe ser única" do
        # Creamos la placa que usaremos en la prueba
          placa_de_prueba = "XYZ-789-#{SecureRandom.hex(4)}"

        # Creamos y guardamos la primera moto para que exista en la base de datos
          Motorcycle.create!(
          license_plate: placa_de_prueba,
          brand: "Honda",
          model: "CBR",
         year: 2020,
          client: @client
        )

          # Intenta crear una segunda moto con la misma placa. La validación debería fallar.
      duplicate_motorcycle = Motorcycle.new(
          license_plate: placa_de_prueba,
          brand: "Yamaha",
          model: "R1",
          year: 2021,
          client: @client
        )
      assert_not duplicate_motorcycle.valid?, "La placa debería ser única."
    end







  test "la moto debe tener un cliente asociado" do
    motorcycle = Motorcycle.new(
      license_plate: "MNO-456-#{SecureRandom.hex(4)}",
      brand: "Kawasaki",
      model: "Ninja",
      year: 2022
      # Faltaría el cliente
    )
    assert_not motorcycle.valid?, "La moto no debería ser válida sin un cliente."
    assert motorcycle.errors[:client].any?, "El error sobre el cliente no está presente."
  end
end
