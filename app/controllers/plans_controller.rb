# app/controllers/plans_controller.rb
class PlansController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /plans
  def index
    # @plans es cargado por CanCanCan
  end

  # GET /plans/1
  def show
    # @plan es cargado por CanCanCan
  end

  # GET /plans/new
  def new
    # @plan es cargado por CanCanCan
  end

  # POST /plans
  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to @plan, notice: 'Plan creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /plans/1/edit
  def edit
    # @plan es cargado por CanCanCan
  end

  # PATCH/PUT /plans/1
  def update
    if @plan.update(plan_params)
      redirect_to @plan, notice: 'Plan actualizado exitosamente.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /plans/1
  def destroy
    @plan.destroy
    redirect_to plans_url, notice: 'Plan eliminado exitosamente.'
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :price, :duration, :details)
  end
end
