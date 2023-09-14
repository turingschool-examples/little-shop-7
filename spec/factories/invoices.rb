FactoryBot.define do
  factory :invoice do
    customer_id { 1 }
    status { "in progress" }
    created_at { Faker::Time.backward(days: 30) }
    updated_at { DateTime.now }
  end
end
