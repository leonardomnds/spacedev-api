class ClientGroup < ApplicationRecord
  acts_as_paranoid

  validates :description, presence: true, uniqueness: { conditions: -> { where(deleted_at: nil) } }

  has_many :clients, dependent: :nullify, inverse_of: :client_group
end
