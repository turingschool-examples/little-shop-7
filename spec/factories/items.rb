FactoryBot.define do
  factory :item, parent: :merchant do
    #name
    name { Faker::Commerce.product_name }
    #description 
    description { Faker::Hipster.sentence(word_count: 3) }
    #unit_price integer
    unit_price { Faker::Number.between(from: 1, to: 10000)}
  end
end
