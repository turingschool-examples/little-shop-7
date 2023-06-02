FactoryBot.define do
  factory :invoice do
    status { "in progress" }
    factory :invoice_with_transaction do
      after(:create) do |invoice|
        create(:transaction, invoice: invoice)
      end
    end
  end

  factory :transaction do 
    credit_card_number { Faker::Number.number(digits: 16) }
    result { "success" }
    credit_card_expiration_date { nil } 
    association :customer, factory: :invoice
  end
end
