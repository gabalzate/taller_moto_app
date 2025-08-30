# app/models/message.rb
class Message < ApplicationRecord
  # Un mensaje pertenece a una única conversación
  belongs_to :conversation

  # Un mensaje es enviado por un usuario, por lo que especificamos la clase y la clave foránea.
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'

  # --- Validaciones ---
  validates :content, :conversation_id, :sender_id, presence: true
end
