## app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # --- Relaciones ---
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
  has_many :clients
  
  # --- Validaciones ---
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :document_number, presence: true, uniqueness: true
end# app/models/user.rb
