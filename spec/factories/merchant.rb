FactoryBot.define do
  factory :merchant do 
    name { Faker::Music::GratefulDead.player }
    status { 0 }
  end
end