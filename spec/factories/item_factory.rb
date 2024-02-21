require 'faker'

FactoryBot.define do
   factory :item do
      name { Faker::Commerce.product_name }
      description { Faker::Commerce.material }
      unit_price { Faker::Number.within(range: 1000..20000) }
      association :merchant
   end
end