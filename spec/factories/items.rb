FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    unit_price { "9.99" }
    merchant_id { 1 }
    created_at { "2023-09-11 16:40:54" }
    updated_at { "2023-09-11 16:40:54" }
  end
end
