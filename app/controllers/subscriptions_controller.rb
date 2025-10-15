# app/controllers/subscriptions_controller.rb
class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  

    # app/controllers/subscriptions_controller.rb

  def index
    @subscription = current_user.subscription
    if @subscription
      # Si la suscripción existe, redirigimos a la página 'show'
      redirect_to @subscription
    else
      # Si no existe, CanCanCan igual previene el acceso no autorizado
      # y se renderizará la vista index (que ahora solo mostrará el mensaje de "sin suscripción")
      authorize! :read, Subscription
    end
  end


  def show
    @subscription = Subscription.find(params[:id])
    authorize! :read, @subscription
  end

  def new
    # Buscamos el plan al que el usuario se quiere suscribir
    @plan = Plan.find(params[:plan_id])
    # Creamos una nueva suscripción en memoria para el formulario
    @subscription = @plan.subscriptions.new(user: current_user)
    authorize! :create, @subscription
  end

  def create
    @plan = Plan.find(params[:plan_id])
    # Verificamos si el usuario ya tiene una suscripción activa
    if current_user.subscription.present? && current_user.subscription.status == 'active'
      redirect_to plans_path, alert: 'Ya tienes una suscripción activa.'
      return
    end

    # Creamos la suscripción asociada al plan y al usuario
    @subscription = @plan.subscriptions.new(user: current_user)
    authorize! :create, @subscription

    # Lógica de fechas
    @subscription.start_date = Time.current
    @subscription.end_date = Time.current + @plan.duration.months
    @subscription.status = 'pending' # Estado inicial antes del pago

    if @subscription.save
      # --- Punto clave para el futuro ---
      # Aquí es donde redirigiríamos a Wompi con los datos de la suscripción.
      # Por ahora, la marcaremos como activa para simular un pago exitoso.
      @subscription.update(status: 'active')
      redirect_to @subscription, notice: "¡Felicidades! Te has suscrito al plan #{@plan.name}."
    else
      render :new, status: :unprocessable_entity
    end
  end
end
