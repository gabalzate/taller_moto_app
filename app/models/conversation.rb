class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :super_admin
end
