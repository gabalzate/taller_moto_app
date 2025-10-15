# app/controllers/entry_orders_controller.rb
class EntryOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_intervention
  load_and_authorize_resource :intervention
  load_and_authorize_resource :entry_order

  def new
    @entry_order = @intervention.build_entry_order
  end


  # app/controllers/entry_orders_controller.rb
  def create
    @entry_order = @intervention.build_entry_order(entry_order_params)
    @entry_order.user = current_user
    if @entry_order.save
      respond_to do |format|
        format.html { redirect_to @intervention, notice: 'Orden de entrada creada exitosamente.' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show
  end

  def edit
  end

  def update
    if @entry_order.update(entry_order_params)
      redirect_to intervention_entry_order_path(@intervention, @entry_order), notice: 'Orden de entrada actualizada exitosamente.'
    else
      render :edit
    end
  end


  private

  def set_intervention
    @intervention = Intervention.find(params[:intervention_id])
  end

  def entry_order_params
    params.require(:entry_order).permit(
      :problem_description,
      :mileage,
      :fuel_level,
      :oil_level,
      :visual_inspection_chassis,
      :tires_condition,
      :front_light_status,
      :turn_signals_status,
      :brake_lights_status,
      :horn_status,
      :battery_status,
      :drive_chain_status,
      :front_brake_status,
      :rear_brake_status,
      :throttle_cable_status,
      :clutch_cable_status,
      :engine_start_status,
      :engine_idle_status,
      :engine_accelerating_status,
      :notes,
      :user_id,
      photos: []
    )
  end
end
