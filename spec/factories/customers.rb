require 'faker'

FactoryBot.define do
  factory :merchant do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end