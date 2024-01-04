FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
  
  factory :customer_with_transactions, parent: :customer do
    after(:create) do |customer, evaluator|
      # assuming a customer has_many :invoices and Invoice has_many :transactions
      create_list(:invoice_with_transactions, 5, customer: customer)
    end
  end
end
