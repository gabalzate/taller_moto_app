# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :authenticate_user!

  # Esta línea es la que verifica los permisos
  authorize_resource class: :dashboard

  def index
  end
end
