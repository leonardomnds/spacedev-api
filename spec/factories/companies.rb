FactoryBot.define do
  factory :company do
    company_name  { Faker::Company.name }
    trading_name  { Faker::Company.name }
    cpf_cnpj      { Faker::Company.ein }
    tenant_name   { 'public' }
  end
end
