FactoryBot.define do
  factory :invoice_item do
    quantity {rand(1..1000)}
    unit_price { Faker::Commerce.price }
    status {rand(0..2)}
  end
end
