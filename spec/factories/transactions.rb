FactoryBot.define do
  factory :transaction do
    invoice { association :invoice }
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date.to_s }
    result { 0 }
  end
end
