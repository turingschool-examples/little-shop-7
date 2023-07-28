FactoryBot.define do
  factory :invoice_item do
    quantity {rand(1..1000)}
    unit_price { Faker::Commerce.price }
  
    trait :shipped do
      status {"shipped"}
    end

    trait :packaged do
      status {"packaged"}
    end

    trait :pending do
      status {"pending"}
    end
  end
end
