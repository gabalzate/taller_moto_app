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
      # El administrador solo puede gestionar lo que le pertenece
      can :manage, Workshop, user_id: user.id
      can :manage, Client, workshop_id: user.workshops.pluck(:id)
      can :manage, Motorcycle, client: { workshop_id: user.workshops.pluck(:id) }
      can :manage, Service, workshop: { user_id: user.id }
      can :manage, Intervention, workshop_id: user.workshops.pluck(:id) # <-- CAMBIO 1: de :read a :manage
      can :manage, Conversation, user_id: user.id
      can :read, Plan
      can [:read, :create], Subscription
      can [:read, :create], Message, conversation: { user_id: user.id }
      can :read, :dashboard
    elsif user.is_mechanic?
      # El mecánico puede leer lo que está en su taller y gestionar hojas de trabajo de su taller
      can :manage, [EntryOrder, ProcedureSheet, OutputSheet], intervention: { workshop_id: user.workshop_id } # <-- CAMBIO 2: Lógica más colaborativa
      can :read, Intervention, workshop_id: user.workshop_id
      can :read, Client, workshop_id: user.workshop_id
      can :read, Motorcycle, client: { workshop_id: user.workshop_id }
      can :create, Message
      can :read, Message, conversation: { user_id: user.id }
      can :create, Conversation, user_id: user.id
      can :read, :dashboard
    else
      # Ningún permiso para usuarios no autenticados
    end
  end
end
