FactoryBot.define do
  factory :invoice do
    customer_id { rand 1..100 }
    # status { ["cancelled", "completed", "in progress"].sample }
    status { rand(0..2) }
  end
end
