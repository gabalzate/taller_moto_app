# test/models/user_test.rb
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "el usuario debe tener un email y un documento únicos" do
    # Crea y guarda un usuario en la base de datos
    user = User.create!(
      first_name: "Juan",
      last_name: "Pérez",
      email: "juan@example.com",
      document_number: "123456789",
      phone_number: "3001234567"
    )
    
    # Intenta crear un usuario con el mismo email. La validación debería fallar.
    duplicate_user = User.new(
      first_name: "Pedro",
      last_name: "Gómez",
      email: "juan@example.com",
      document_number: "987654321",
      phone_number: "3009876543"
    )
    assert_not duplicate_user.valid?, "El email debería ser único."

    # Intenta crear un usuario con el mismo documento. La validación debería fallar.
    another_duplicate = User.new(
      first_name: "Ana",
      last_name: "García",
      email: "ana@example.com",
      document_number: "123456789",
      phone_number: "3001112233"
    )
    assert_not another_duplicate.valid?, "El documento debería ser único."
  end
end
