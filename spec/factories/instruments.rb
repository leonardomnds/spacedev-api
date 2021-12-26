FactoryBot.define do
  factory :instrument do
    client            { find_or_create(:client) }
    tag               { Faker::Lorem.characters(number: 10) }
    description       { Faker::Lorem.sentence }
    calibration_time  { Faker::Number.between(from: 0, to: 24) }
    responsible       { Faker::Name.name }
    area              { Faker::Lorem.word }
    subarea           { Faker::Lorem.word }
    manufacturer      { Faker::Lorem.word }
    serial_number     { Faker::Lorem.characters(number: 10) }
    range             { Faker::Lorem.word }
    resolution        { Faker::Lorem.word }

    factory :inactive_instrument do
      active { false }
    end
  end
end
