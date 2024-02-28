FactoryBot.define do
    factory :invoice_item do
      association :item
      association :invoice
      quantity { 1 }
      unit_price { 10 }
      status { "pending" }
    end
  end
