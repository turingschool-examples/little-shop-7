FactoryBot.define do
  factory :merchant do
    name { Faker::JapaneseMedia::DragonBall.character }
    status { true }
  end
end
