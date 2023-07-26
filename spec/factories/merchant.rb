FactoryBot.define do
  factory :merchant do 
    name { Faker::Name.name }
    status { 0 }
  end
end