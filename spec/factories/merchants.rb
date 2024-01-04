FactoryBot.define do
  factory :merchant do
#     # id { rand(1..99) }
#     # id { (1..110).to_a.sample }
#     initialize_with { new(id: rand(1..99)) }
    name { Faker::Company.name }
  end
end