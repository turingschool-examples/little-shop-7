FactoryBot.define do 
  factory :invoice do 
    customer
    status { ["in progress", "completed", "cancelled"].sample }
  end
end