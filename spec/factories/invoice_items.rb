FactoryBot.define do
  factory :invoice_item do
    item_id { 1 }
    invoice_id { 1 }
    quantity { 1 }
    unit_price { "9.99" }
    status { 1 }
    created_at { "2023-09-11 16:36:27" }
    updated_at { "2023-09-11 16:36:27" }
  end
end
