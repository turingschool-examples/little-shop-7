FactoryBot.define do
  factory :merchant do
    quantity { rand(1..10) }
    status { rand(0..2)}
  end
end