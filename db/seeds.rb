# db/seeds.rb

# Crear un super administrador si no existe
if User.where(is_super_admin: true).count == 0
  User.create!(
    first_name: "Super",
    last_name: "Admin",
    email: "super_admin@example.com",
    password: "password", # <- Agregamos esta línea
    password_confirmation: "password", # <- Y esta línea
    document_number: "00000000",
    phone_number: "1111111111",
    is_super_admin: true,
    is_admin: true,
    is_mechanic: true
  )
end
