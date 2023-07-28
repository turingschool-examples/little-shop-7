FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Games::Zelda.item }
    description { Faker::Games::Pokemon.move }
    unit_price { Faker::Commerce.price }
  end
end
