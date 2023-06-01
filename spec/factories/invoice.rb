FactoryBot.define do
  factory :invoice do
    customer
    status {"completed"}
  end
end