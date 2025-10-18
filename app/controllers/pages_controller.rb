# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  # --- LÍNEA AÑADIDA ---
  # Saltamos la autenticación de Devise SOLO para la página 'home'.
  skip_before_action :authenticate_user!, only: [:home]
  # --- FIN DE LA LÍNEA ---

  def home
  end
end
