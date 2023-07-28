FactoryBot.define do
  factory :transaction do
    #association :invoice 

    credit_card_number {Faker::Number.number(digits:16)}
    credit_card_expiration_date {"04/27"}
    
    trait :success do
      result  { "success" }
    end

    trait :failed do
      result  { "failed" }
    end
  end
end
