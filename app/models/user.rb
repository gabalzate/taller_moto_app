## app/models/user.rb
class User < ApplicationRecord
  # Relaciones para administradores
  has_many :workshops
  has_one :subscription
  
  # Relaciones para mecánicos
  belongs_to :workshop, optional: true
  has_many :procedure_sheets
  has_many :entry_orders
  has_many :output_sheets
  
  # Relaciones con el sistema de chat y mensajería
  has_many :conversations
  has_many :super_admin_conversations, class_name: 'Conversation', foreign_key: 'super_admin_id'
  has_many :messages, foreign_key: 'sender_id'
  
  # Relación con clientes
  has_many :clients # <-- Esta es la línea que faltaba
  
  # Validaciones (se agregarán en un paso posterior)
end app/models/user.rb
