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
        can :manage, Motorcycle, client: { workshop_id: user.workshop.id }
        can :manage, Intervention, workshop_id: user.workshop.id
        can :manage, Service, workshop_id: user.workshop.id
      end
      # ------------------------

      # Permisos que no dependen de tener un taller
      can :manage, Conversation, user_id: user.id
      can :read, Plan
      can [:read, :create], Subscription
      can [:read, :create], Message, conversation: { user_id: user.id }
      can :read, :dashboard



    elsif user.is_mechanic?
      # --- LÍNEAS MODIFICADAS ---
      # El mecánico puede leer lo que está en su taller y gestionar hojas de trabajo de su taller.
      can :manage, [EntryOrder, ProcedureSheet, OutputSheet], intervention: { workshop_id: user.workplace_id }
      can :read, Intervention, workshop_id: user.workplace_id
      can :read, Client, workshop_id: user.workplace_id
      can :read, Motorcycle, client: { workshop_id: user.workplace_id }


    else
      # Ningún permiso para usuarios no autenticados
    end
  end
end
