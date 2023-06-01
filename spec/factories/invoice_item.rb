FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    item
    invoice
    quantity {Faker::Number.number(digits: 1)}
    unit_price {Faker::Number.number(digits: 4)}
    status {Faker::Number.between(from: 0, to: 2)}
  end
end