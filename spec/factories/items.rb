FactoryBot.define do
  factory :item do 
    name { Faker::Commerce.product_name}
    description { Faker::Lorem.sentence}
    unit_price { Faker::Number.between(from: 100, to: 500000) }
  end
end