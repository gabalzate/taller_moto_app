## app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # --- Relaciones ---
  # Relaciones para administradores
  has_one :workshop, foreign_key: 'user_id', dependent: :destroy
  has_one :subscription

  # Relaciones para mecánicos
  belongs_to :workplace, class_name: 'Workshop', foreign_key: 'workshop_id', optional: true
  has_many :procedure_sheets
  has_many :entry_orders
  has_many :output_sheets
  # Un usuario (mecánico) puede tener muchas intervenciones asignadas.
  has_many :assigned_interventions, class_name: 'Intervention', foreign_key: 'mechanic_id'

  # Relaciones con el sistema de chat y mensajería
  has_many :conversations
  has_many :super_admin_conversations, class_name: 'Conversation', foreign_key: 'super_admin_id'
  has_many :messages, foreign_key: 'sender_id'

  extend FriendlyId
  # Genera la URL a partir de la combinación de nombre y apellido.
  friendly_id :full_name, use: :slugged

  # Un método simple para combinar nombre y apellido.
  def full_name
    "#{first_name} #{last_name}"
  end

  # Relación con clientes
  has_many :clients
  
  # --- Validaciones ---
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :document_number, presence: true, uniqueness: true
end
