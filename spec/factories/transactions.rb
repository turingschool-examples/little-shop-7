FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date }
    result { Transaction.results.values.sample }
  end
end
