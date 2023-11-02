require "faker"

# FactoryBot.define do
#   factory :item do
#     name { Faker::Name.name }
#     description {Faker::Marketing.buzzwords}
#     unit_price {Faker::Commerce.price}
#     merchant_id {Faker::Number.number(digits: 1)}
#   end
# end

FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.within(range: 1..10000) } # adjust range as necessary
    association :merchant
  end
end