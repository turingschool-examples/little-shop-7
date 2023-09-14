FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "Merchant #{n}" }

    created_at { "2023-09-11 16:41:38" }
    updated_at { "2023-09-11 16:41:38" }
  end
end
