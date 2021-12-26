FactoryBot.define do
  factory :user do
    company   { find_or_create(:company) }
    name      { Faker::Company.name }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password }

    factory :inactive_user do
      active { false }
    end

    factory :admin_user do
      is_admin { false }
    end

    factory :auth_user do
      session_token { Faker::Lorem.word }
    end
  end
end
