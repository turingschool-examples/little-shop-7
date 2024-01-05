FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.department }
    unit_price { Faker::Number.number(digits: 4) }
  end
end
