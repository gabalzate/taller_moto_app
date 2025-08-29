# app/models/subscription.rb
class Subscription < ApplicationRecord
  # Una suscripción pertenece a un usuario y a un plan
  belongs_to :user
  belongs_to :plan
end
