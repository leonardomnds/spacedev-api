FactoryBot.define do
  factory :client do
    cpf_cnpj          { Faker::Company.ein }
    company_name      { Faker::Company.name }
    trading_name      { Faker::Company.name }
    document_number   { Faker::Company.ein }
    email             { Faker::Internet.email }
    password          { Faker::Internet.password }
    phone             { Faker::PhoneNumber.phone_number }
    cel_phone         { Faker::PhoneNumber.phone_number }

    factory :inactive_client do
      active { false }
    end

    factory :client_with_group do
      group { find_or_create(:client_group) }
    end
  end
end
