FactoryBot.define do
  factory :customer do
    first_name { Faker::TvShows::RickAndMorty.character }
    last_name { Faker::Movies::StarWars.character }
  end
end
