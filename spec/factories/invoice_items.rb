
FactoryBot.define do
  factory :invoice_item do
    association :item
    association :invoice
    quantity { Faker::Number.between(from: 1, to: 20)}
    unit_price { Item.find(item_id).unit_price }
    status { InvoiceItem.statuses.values.sample }
  end
end
