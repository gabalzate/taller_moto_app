# app/models/plan.rb
class Plan < ApplicationRecord
  # Un plan puede tener muchas suscripciones
  has_many :subscriptions

  # --- Validaciones ---
  validates :name, :price, :duration, presence: true
end
