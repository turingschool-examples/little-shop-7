require 'faker'

FactoryBot.define do
   factory :invoice_item do
      association :invoice 
      association :item
      quantity { Faker::Number.within(range: 1..5) }
      unit_price { Faker::Number.within(range: 1000..20000) }
      status { Faker::Number.between(from: 0, to: 2) }
   end
end