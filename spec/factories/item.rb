FactoryBot.define do
  factory :item, class: "Item" do 
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Number.between(from: 100, to: 10000) }
    association :merchant
  end
end