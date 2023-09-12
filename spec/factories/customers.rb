FactoryBot.define do
  factory :customer do
    first_name { "Abel" }
    last_name { "Anderson" }
  end

  factory :bruce, class: Customer do
    first_name { "Bruce" }
    last_name { "Baker" }
  end

  # factory :chris do
  #   first_name "Chris"
  #   last_name "Christopher"
  # end

  # factory :dave do
  #   first_name "Dave"
  #   last_name "Davidson"
  # end

  # factory :elliot do
  #   first_name "Elliot"
  #   last_name "Eagle"
  # end

  # factory :frank do
  #   first_name "Frank"
  #   last_name "Fullerton"
  # end

  # factory :gene do
  #   first_name "Gene"
  #   last_name "Georges"
  # end
end