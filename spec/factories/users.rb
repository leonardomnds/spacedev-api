FactoryBot.define do
  factory :user do
    name      { Faker::Company.name }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password }
    company   { Company.first.presence || create(:company) }

    factory :inactive_user do
      active { false }
    end

    factory :admin_user do
      is_admin { true }
    end

    factory :auth_user do
      session_token { Faker::Lorem.word }
    end
  end
end
