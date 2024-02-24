FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Commerce.material }
    unit_price { Faker::Commerce.price(range: 100..99999).to_i }
    merchant { association :merchant }
    status { 0 }
  end
end
