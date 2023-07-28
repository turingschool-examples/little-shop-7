FactoryBot.define do
  factory :invoice do
    #association :customer
    #association :transaction
    #association :invoice_item
    status {rand(0..2)}
  end
end
