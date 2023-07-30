FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    status { true }
  end
end
