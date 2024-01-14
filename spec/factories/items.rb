FactoryBot.define do
  factory :item do
    name { Faker::Games::Minecraft.unique.item }
    description { Faker::Food.description }
    unit_price { Faker::Number.number(digits: 5)}
    association :merchant
  end
end
