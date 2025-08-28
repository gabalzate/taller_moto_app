class ProcedureSheet < ApplicationRecord
  belongs_to :intervention
  belongs_to :user
end
