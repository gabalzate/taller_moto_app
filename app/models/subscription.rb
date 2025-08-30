# app/models/subscription.rb
class Subscription < ApplicationRecord
  # Una suscripción pertenece a un usuario y a un plan
  belongs_to :user
  belongs_to :plan

  # --- Validaciones ---
  validates :start_date, :end_date, presence: true
  validate :end_date_is_after_start_date

  private

  def end_date_is_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "debe ser posterior a la fecha de inicio")
    end
  end
end
