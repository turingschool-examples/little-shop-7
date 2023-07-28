FactoryBot.define do
  factory :merchant do
    #association :item
    name { Faker::JapaneseMedia::DragonBall.character }
  end
end
