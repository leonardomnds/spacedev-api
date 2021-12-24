class User < ApplicationRecord
  acts_as_paranoid
  has_secure_password

  validates :email, uniqueness: true
  validates :name, :email, :password, :company_id, presence: true

  belongs_to :company

  scope :not_admin, -> { where(is_admin: false) }
end
