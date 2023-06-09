FactoryBot.define do
  factory :coupon do
    code { Faker::Commerce.promotion_code(digits: 2) }
    name { Faker::Commerce.promotion_code(digits: 2) }
    status { rand(0..1) }
    value { Faker::Commerce.price(range: 0..99) }
    type { rand(0..1) }
  end
end
