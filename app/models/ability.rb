# frozen_string_literal: true
# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define las habilidades para el usuario.
    user ||= User.new # Usuario no autenticado (invitado)

    if user.is_super_admin?
      can :manage, :all
    



    elsif user.is_admin?
      # El administrador puede gestionar su propio taller.
      can :manage, Workshop, user_id: user.id

      # --- BLOQUE CORREGIDO ---
      # Estas reglas solo se aplican SI el usuario ya tiene un taller registrado.
      if user.workshop
        can :manage, Client, workshop_id: user.workshop.id
        can [:new, :create], Motorcycle # 1. Permite al admin entrar al formulario para crear.
        can [:read, :update, :destroy], Motorcycle, client: { workshop_id: user.workshop.id } # 2. Mantiene la seguridad para motos que ya existen.
        can :manage, Intervention, workshop_id: user.workshop.id
        can :manage, [EntryOrder, ProcedureSheet, OutputSheet], intervention: { workshop_id: user.workshop.id }
        can :manage, Service, workshop_id: user.workshop.id
        # Permite al admin gestionar usuarios (CRUD) que sean mecánicos
        # y que pertenezcan ('workshop_id') a su propio taller.
        can :create, User # 1. Permite al admin INICIAR la creación de cualquier usuario para su taller.
        can [:read, :update, :destroy], User, workshop_id: user.workshop.id, is_mechanic: true # 2. Mantiene la seguridad para mecánicos que ya existen.
      end
      # ------------------------

      # Permisos que no dependen de tener un taller
      can :manage, Conversation, user_id: user.id
      can :read, Plan
      can [:read, :create], Subscription
      can [:read, :create], Message, conversation: { user_id: user.id }
      can :read, :dashboard


    elsif user.is_mechanic?
      # Permisos para gestionar el ciclo de una intervención.
      # Usamos user.workplace&.id para obtener de forma segura el ID del taller.
      can :manage, [EntryOrder, ProcedureSheet, OutputSheet], intervention: { workshop_id: user.workplace&.id }
      can [:read, :create], Intervention, workshop_id: user.workplace&.id

      # Un mecánico ahora puede CREAR y LEER clientes y motos de su taller.
      can [:read, :create], Client, workshop_id: user.workplace&.id
      can :create, Motorcycle # 1. Permite al mecánico entrar al formulario para crear una moto.
      can :read, Motorcycle, client: { workshop_id: user.workplace&.id } # 2. Mantiene la seguridad para motos que ya existen.

      # Permisos para el chat.
      can :create, Message
      can :read, Message, conversation: { user_id: user.id }
      can :create, Conversation, user_id: user.id
      can :read, :dashboard




    else
      # Ningún permiso para usuarios no autenticados
    end
  end
end
