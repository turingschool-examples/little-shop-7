# FactoryBot.define do
#   factory :transaction do
#     credit_card_number { Faker::Number.number(digits: 16) }
#     result { "success" }
#     credit_card_expiration_date { nil } 
#     association :customer, factory: :invoice
#   end
# end
