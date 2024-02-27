FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    status { 0 }
  end
end
