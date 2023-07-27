FactoryBot.define do
  factory :merchant do
    name { Faker::TvShows::RickAndMorty.character }
  end
end
