FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number { Faker::Bank.account_number(digits: 16) }
    credit_card_expiration_date { Faker::Date.forward(days: 365 * rand(1..5)).strftime('%m/%y') }
    result { Faker::Number.between(from: 0, to: 1) }
  end
end
