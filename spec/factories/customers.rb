FactoryBot.define do 
  factory :customer do
    first_name { Faker::JapaneseMedia::DragonBall.character }
    last_name { Faker::JapaneseMedia::DragonBall.character }
    created_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
    updated_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now, format: :default) }
  end
end