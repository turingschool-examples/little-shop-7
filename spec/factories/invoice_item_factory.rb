FactoryBot.define do
  factory :invoice_item do

    quantity { Faker::Number.between(from: 1, to: 100) }
    unit_price { Faker::Number.between(from: 1, to: 100) }
    status { ['pending', 'packaged', 'shipped'] }

    association :item, factory: :item
    association :invoice, factory: :invoice
  end
end