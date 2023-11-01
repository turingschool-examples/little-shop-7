require "faker"

FactoryBot.define do
  factory :transaction do
    credit_card_expiration_date { rand(1..12).to_s + "/" + rand(23..30).to_s }
    credit_card_number { rand() }
    result { rand(0..1) }
    association :invoice
  end
end