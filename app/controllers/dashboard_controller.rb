# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.is_super_admin?
      @total_workshops = Workshop.count
      @active_subscriptions = Subscription.where(status: 'active').count
      @pending_subscriptions = Subscription.where(status: 'pending').count
    elsif current_user.is_admin?
      @workshop = current_user.workshop
      if @workshop
        @motorcycles_in_workshop = @workshop.interventions.where.not(status: 'Completada').count
        @completed_interventions_month = @workshop.interventions.where(status: 'Completada').where("output_date >= ?", Time.current.beginning_of_month).count
        @recent_activities = @workshop.interventions.order(created_at: :desc).limit(5)
      end
    end
  end
end
