# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  # Le decimos a la app que, si el controlador es de Devise, no ejecute nuestro filtro.
  before_action :check_subscription_status, unless: :devise_controller?
  # La autenticación de Devise se ejecuta primero para toda la aplicación.
  before_action :authenticate_user!

  # --- INICIO DEL NUEVO BLOQUE ---
  # Este es nuestro "muro de suscripción". Se ejecuta después de la autenticación.
  # before_action :check_subscription_status - comentareo por si acaso

  private

  def check_subscription_status
    # La lógica solo se aplica si el usuario ha iniciado sesión Y es un administrador.
    # No afecta a los mecánicos ni al super administrador.
    return unless user_signed_in? && current_user.is_admin?

    # Permitimos el acceso si el usuario es un super admin (que también es admin).
    return if current_user.is_super_admin?

    # Verificamos si la suscripción del administrador está activa.
    # Usamos 'any?' para evitar errores si 'subscription' es nil.
    has_active_subscription = current_user.subscription&.status == 'active'

    # Si NO tiene una suscripción activa Y NO está ya en una página permitida...
    unless has_active_subscription || allowed_path?
      # ...lo redirigimos forzosamente a la página de planes.
      redirect_to plans_path, alert: "Debes tener una suscripción activa para continuar."
    end
  end

  # Este método define las páginas a las que un admin SIN suscripción SÍ puede acceder.
  def allowed_path?
    # Permitimos el acceso a las páginas de planes, suscripciones y cierre de sesión.
    # Esto evita un bucle de redirección infinito.
    request.path.include?('/plans') || 
    request.path.include?('/subscriptions') || 
    request.path.include?('/users/sign_out')
  end


  # Sobrescribe el método de Devise para redirigir después del inicio de sesión.
  def after_sign_in_path_for(resource)
    # 'resource' es el usuario que acaba de iniciar sesión.
    # Redirigimos a la ruta del dashboard en lugar de la raíz.
    dashboard_path 
  end



end
