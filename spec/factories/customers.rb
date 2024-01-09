FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :customer_with_transactions, parent: :customer do
    transient do
      transactions_count { 5 }  # Default value, can be set in spec 
    end

    after(:create) do |customer, evaluator|
      # the customer has invoices
      invoices = create_list(:invoice, evaluator.transactions_count, customer: customer)

      # each invoice has a transaction
      invoices.each do |invoice|
        create_list(:transaction, 1, invoice: invoice)
      end
    end
  end
end
