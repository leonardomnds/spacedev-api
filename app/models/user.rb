class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password validations: false

  validates :email, uniqueness: true
  validates :password, presence: true, on: :create
  validates :name, :email, :company_id, presence: true

  belongs_to :company

  scope :not_admin, -> { where(is_admin: false) }
end
