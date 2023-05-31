FactoryBot.define do 
  factory :transaction do 
    invoice 
    credit_card_number { Faker::Number.number(digits: 16) }
    # result { ["success", "failed"].sample }
    result { Faker::Boolean.boolean ? "success" : "failed"} 
  end
end