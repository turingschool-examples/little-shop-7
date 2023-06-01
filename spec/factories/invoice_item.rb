FactoryBot.define do
  factory :invoiceitem do
    item_id {"1"}
    invoice_id {"2"}
    quantity {"2"}
    unit_price {"2300"}
    status {"Shipped"}
  end
end