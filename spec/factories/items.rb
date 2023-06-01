FactoryBot.define do
  factory :item do
    name {Faker::Appliance.equipment}
    unit_price {Faker::Number.number(digits: 4)}
    merchant
  end
end