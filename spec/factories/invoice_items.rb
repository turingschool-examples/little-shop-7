FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 0, to: 10) }
    unit_price { Faker::Number.between(from: 50, to: 10000) }
    status { rand(0..2) }
    association :item, factory: :item
    association :invoice, factory: :invoice
  end
end