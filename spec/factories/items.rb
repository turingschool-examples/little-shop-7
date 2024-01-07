FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "#{Faker::Commerce.product_name} #{n}" }
    description { Faker::Commerce.department }
    unit_price { Faker::Number.number(digits: 4) }
  end
end
