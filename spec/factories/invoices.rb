FactoryBot.define do
  factory :invoice do
    association :customer
    status { Faker::Number.between(from: 0, to: 2) }
  end

  factory :invoice_with_transactions, parent: :invoice do
    after(:create) do |invoice, evaluator|
      create_list(:transaction, 5, invoice: invoice) # change number of transactions if needed
    end
  end
end
