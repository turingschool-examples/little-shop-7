FactoryBot.define do
  factory :invoice do
    association :customer
    status { Invoice.statuses.values.sample }
  end
end
