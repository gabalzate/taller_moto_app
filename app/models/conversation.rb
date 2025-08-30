# app/models/conversation.rb
class Conversation < ApplicationRecord
  # Una conversación pertenece a un usuario (quien la inicia)
  belongs_to :user

  # Una conversación pertenece a un super administrador
  belongs_to :super_admin, class_name: 'User'

  # Una conversación tiene muchos mensajes
  has_many :messages

  # --- Validaciones ---
  validates :user_id, :super_admin_id, presence: true
end
