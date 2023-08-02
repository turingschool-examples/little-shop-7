FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    status { true }
    trait :false do
      status  { false }
    end
  end
end