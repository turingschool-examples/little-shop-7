FactoryBot.define do
<<<<<<< HEAD
    factory :invoice_item do
      association :item 
      association :invoice 
      quantity { 1 }
      unit_price { 10 }
      status { "pending" }
    end
  end
=======
  factory :invoice_item do

    quantity { Faker::Number.between(from: 1, to: 100) }
    unit_price { Faker::Number.between(from: 1, to: 100) }
    status { ['pending', 'packaged', 'shipped'].sample }

    association :item, factory: :item
    association :invoice, factory: :invoice
  end
end
>>>>>>> 82a3c8bd6be4c994523b1c89b4446485ba465964
