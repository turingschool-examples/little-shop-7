FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Device.model_name }
    description { Faker::JapaneseMedia::OnePiece.quote }
    unit_price { Faker::Commerce.price }
  end
end
