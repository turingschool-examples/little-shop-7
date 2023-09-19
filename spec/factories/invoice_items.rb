FactoryBot.define do
  factory :invoice_item do
    association :user
    association :invoice
    quantity { 1 }
    unit_price { item.unit_price }
    status { invoice.status }
    created_at { invoice.created_at }
    updated_at { invoice.updated_at }
  end
end
