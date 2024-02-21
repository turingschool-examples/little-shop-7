FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.product_description }
    unit_price { Faker::Commerce.price(100..99999).to_i }
    merchant { association :merchant }
  end
end
