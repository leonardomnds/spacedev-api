class Company < ApplicationRecord
  has_paper_trail
  acts_as_paranoid

  before_validation :only_numbers_cpf_cnpj, :downcase_tenant_name

  validates :tenant_name, uniqueness: true
  validates :company_name, :cpf_cnpj, :tenant_name, presence: true

  has_many :users, dependent: :destroy, inverse_of: :company

  scope :with_schema, -> { where('companies.tenant_name IN (SELECT nspname FROM pg_catalog.pg_namespace)') }

  def only_numbers_cpf_cnpj
    return if cpf_cnpj.blank?

    self.cpf_cnpj = cpf_cnpj.scan(/\d/).join('')
  end

  def downcase_tenant_name
    return if tenant_name.blank?

    self.tenant_name = tenant_name.downcase
  end
end
