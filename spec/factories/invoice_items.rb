FactoryBot.define do 
  factory :invoice_item do 
    item
    invoice 
    quantity { rand(1..100) }
    unit_price { Faker::Number.between(from: 100, to: 500000) }
    status { ["pending", "packaged", "shipped"].sample }
  end
end