FactoryBot.define do
  factory :calibration do
    instrument          { Instrument.first.presence || create(:instrument) }
    date                { Faker::Date.between(from: 1.year.ago.to_date, to: Time.zone.today) }
    laboratory          { Faker::Lorem.word }
    certificate_number  { Faker::Lorem.characters(number: 10) }
  end
end
