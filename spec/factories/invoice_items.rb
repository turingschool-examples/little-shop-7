FactoryBot.define do
  factory :invoice_item do
    item { association :item }
    invoice { association :invoice }
    quantity { Faker::Number.number(digits: 1) }
    unit_price { 1 }
    status { 1 }
  end
end
