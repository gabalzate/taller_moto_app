# test/models/subscription_test.rb
require "test_helper"
require "securerandom"

class SubscriptionTest < ActiveSupport::TestCase
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

    # Crea un plan de prueba para que la suscripción tenga a quién asociarse
    @plan = Plan.create!(
      name: "Plan Pro #{SecureRandom.hex(4)}",
      price: 50.00,
      duration: 12
    )
  end

  test "una suscripción es válida con todos los atributos correctos" do
    subscription = Subscription.new(
      user: @admin_user,
      plan: @plan,
      start_date: DateTime.now,
      end_date: DateTime.now + 1.month,
      status: "active"
    )
    assert subscription.valid?, "La suscripción no debería ser válida: #{subscription.errors.full_messages}"
  end
  
  test "una suscripción no es válida si la fecha de finalización es anterior a la fecha de inicio" do
    subscription = Subscription.new(
      user: @admin_user,
      plan: @plan,
      start_date: DateTime.now,
      end_date: DateTime.now - 1.day,
      status: "active"
    )
    assert_not subscription.valid?, "La suscripción no debería ser válida con una fecha de finalización anterior a la de inicio."
    assert subscription.errors[:end_date].any?, "El error sobre la fecha de finalización no está presente."
  end
  
  test "una suscripción no es válida sin un usuario y un plan asociados" do
    subscription = Subscription.new(
      start_date: DateTime.now,
      end_date: DateTime.now + 1.month,
      status: "active"
      # Faltarían el usuario y el plan
    )
    assert_not subscription.valid?, "La suscripción no debería ser válida sin usuario y plan."
    assert subscription.errors[:user].any?, "El error sobre el usuario no está presente."
    assert subscription.errors[:plan].any?, "El error sobre el plan no está presente."
  end
end
