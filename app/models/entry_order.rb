# app/models/entry_order.rb
class EntryOrder < ApplicationRecord
  # Una orden de entrada pertenece a una única intervención
  belongs_to :intervention

  # Una orden de entrada es creada por un usuario
  belongs_to :user
end
