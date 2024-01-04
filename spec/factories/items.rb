FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Games::HalfLife.location }
    unit_price { Faker::Number.number(digits: 4) }
  end
end
