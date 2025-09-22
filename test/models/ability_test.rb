# test/models/ability_test.rb
require "test_helper"
require "securerandom"

class AbilityTest < ActiveSupport::TestCase
  def setup
    # Crea un taller y un usuario administrador asociado
    @admin_user = User.create!(
      first_name: "Test",
      last_name: "Admin",
      email: "admin_#{SecureRandom.hex(4)}@example.com",
      document_number: SecureRandom.hex(8),
      phone_number: "555-1111",
      is_admin: true,
      password: "password",
      password_confirmation: "password"
    )
    @workshop = Workshop.create!(
      name: "Taller de Prueba #{SecureRandom.hex(4)}",
      city: "Medellín",
      user: @admin_user
    )

    # Crea un usuario mecánico y lo asocia al taller
    @mechanic_user = User.create!(
      first_name: "Test",
      last_name: "Mecánico",
      email: "mechanic_#{SecureRandom.hex(4)}@example.com",
      document_number: SecureRandom.hex(8),
      phone_number: "555-2222",
      is_mechanic: true,
      workshop: @workshop,
      password: "password",
      password_confirmation: "password"
    )

    # Crea un super administrador y lo asocia a un taller
    @super_admin = User.create!(
      first_name: "Test",
      last_name: "SuperAdmin",
      email: "super_admin_#{SecureRandom.hex(4)}@example.com",
      document_number: SecureRandom.hex(8),
      phone_number: "555-3333",
      is_super_admin: true,
      password: "password",
      password_confirmation: "password"
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

  test "el super administrador puede gestionar todo" do
    ability = Ability.new(@super_admin)
    assert ability.can?(:manage, :all), "El super administrador debería poder gestionar todo."
  end

  test "el administrador puede gestionar sus propios talleres, clientes, y motocicletas" do
    ability = Ability.new(@admin_user)
    assert ability.can?(:manage, @workshop), "El administrador debería poder gestionar su propio taller."
    assert ability.can?(:manage, @client), "El administrador debería poder gestionar a su propio cliente."
    assert ability.can?(:manage, @motorcycle), "El administrador debería poder gestionar su propia motocicleta."
    # Cambiamos la prueba para verificar que el administrador puede leer
    assert ability.can?(:read, @intervention), "El administrador debería poder leer su propia intervención."
    # Cambiamos la prueba para verificar que el administrador NO puede gestionar
    assert ability.cannot?(:manage, @intervention), "El administrador no debería poder gestionar intervenciones."
  end

  test "el mecánico solo puede gestionar las intervenciones y leer los datos de su taller" do
    ability = Ability.new(@mechanic_user)
    # Cambiamos la prueba para verificar que el mecánico puede gestionar EntryOrder (documentos de la intervención)
    assert ability.can?(:manage, EntryOrder), "El mecánico debería poder gestionar una Orden de Entrada."
    # Cambiamos la prueba para verificar que el mecánico solo puede leer la intervención
    assert ability.can?(:read, @intervention), "El mecánico debería poder leer la intervención de su taller."
    assert ability.can?(:read, @motorcycle), "El mecánico debería poder leer la motocicleta de su taller."
    assert ability.can?(:read, @client), "El mecánico debería poder leer el cliente de su taller."
    assert ability.cannot?(:read, @workshop), "El mecánico no debería poder leer el taller."
    assert ability.cannot?(:manage, @motorcycle), "El mecánico no debería poder gestionar una motocicleta."
  end
end
