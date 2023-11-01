require "faker"

FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Marketing.buzzwords }
    unit_price { rand(10000..99999) }
    association :merchant
  end
end