FactoryBot.define do
  factory :invoice do
    customer_id {"1"}
    status {"completed"}
    quantity {"2"}
  end
end