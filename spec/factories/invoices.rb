FactoryBot.define do
  factory :invoice do
    association :customer 
    status {rand(0..2)}
  end
end
