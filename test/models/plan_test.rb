# test/models/plan_test.rb
require "test_helper"
require "securerandom"

class PlanTest < ActiveSupport::TestCase
  # El método setup se ejecuta antes de cada test.
  def setup
    @plan_valid = {
      name: "Plan Básico #{SecureRandom.hex(4)}",
      price: 20.00,
      duration: 1
    }
  end

  test "un plan es válido con todos los atributos correctos" do
    plan = Plan.new(@plan_valid)
    assert plan.valid?, "El plan no debería ser válido: #{plan.errors.full_messages}"
  end
  
  test "un plan no es válido sin un nombre, precio y duración" do
    plan = Plan.new(name: nil)
    assert_not plan.valid?, "El plan no debería ser válido sin nombre."
    assert plan.errors[:name].any?, "El error sobre el nombre no está presente."
    
    plan = Plan.new(price: nil)
    assert_not plan.valid?, "El plan no debería ser válido sin precio."
    assert plan.errors[:price].any?, "El error sobre el precio no está presente."
    
    plan = Plan.new(duration: nil)
    assert_not plan.valid?, "El plan no debería ser válido sin duración."
    assert plan.errors[:duration].any?, "El error sobre la duración no está presente."
  end
end
