FactoryBot.define do
  factory :transaction do
    credit_card_number { "1234 5567 8659 3020" }
    credit_card_expiration_date { "09/28" }
    result { [0,1].sample } #look into this 
  end
end