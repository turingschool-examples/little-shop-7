require 'faker'

FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.within(range: 1..10) } 
    unit_price { Faker::Number.within(range: 1..100) } 
    association :item
    association :invoice
  end
end