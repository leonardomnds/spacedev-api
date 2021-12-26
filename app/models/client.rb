class Client < ApplicationRecord
  acts_as_paranoid
  has_secure_password validations: false

  before_validation :only_numbers_cpf_cnpj

  validates :cpf_cnpj, uniqueness: { conditions: -> { where(deleted_at: nil) } }
  validates :password, presence: true, on: :create
  validates :cpf_cnpj, :company_name, presence: true

  belongs_to :client_group, optional: true

  has_many :instruments, dependent: :destroy, inverse_of: :client

  scope :active, -> { where(active: true) }
  scope :by_cpf_cnpj, ->(cpf_cnpj) { where(cpf_cnpj: cpf_cnpj.scan(/\d/).join('')) }

  def only_numbers_cpf_cnpj
    return if cpf_cnpj.blank?

    self.cpf_cnpj = cpf_cnpj.scan(/\d/).join('')
  end
end
