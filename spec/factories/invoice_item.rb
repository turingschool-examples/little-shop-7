FactoryBot.define do
  factory :invoice_item do
    association :invoice
    association :item
    quantity { [1,2,3,4,5].sample }
    unit_price { Faker::Commerce.price(range: 0..10000.0) }
    status { [0,1,2].sample }
  end
end