FactoryBot.define do
  factory(:item) do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentences(number: 1) }
    unit_price { (Faker::Commerce.price * 100).to_i }
    merchant
  end
end
