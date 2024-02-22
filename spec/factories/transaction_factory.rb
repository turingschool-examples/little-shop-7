FactoryBot.define do
  factory :transaction do
    credit_card_number { "4504301557459341" }
    credit_card_expiration_date { "04/28" }
    result { "success" }
    invoice
  end
end
