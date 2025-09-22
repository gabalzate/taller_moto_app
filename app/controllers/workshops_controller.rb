# app/controllers/workshops_controller.rb
class WorkshopsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @workshops = Workshop.all
  end

  def show
  end

  def new
    @workshop = Workshop.new
  end

  def create
    @workshop = Workshop.new(workshop_params)
    @workshop.user = current_user
    if @workshop.save
      redirect_to @workshop, notice: 'Taller creado exitosamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @workshop.update(workshop_params)
      redirect_to @workshop, notice: 'Taller actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @workshop.destroy
    redirect_to workshops_url, notice: 'Taller eliminado exitosamente.'
  end

  private

  def workshop_params
    params.require(:workshop).permit(:name, :phone, :city, :address, :details, :opening_hours, :unique_profile_link, :status)
  end
end
