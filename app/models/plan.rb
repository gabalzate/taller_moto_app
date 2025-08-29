# app/models/plan.rb
class Plan < ApplicationRecord
  # Un plan puede tener muchas suscripciones
  has_many :subscriptions
end
