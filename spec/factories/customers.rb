FactoryBot.define do
  factory :customer do
    first_name { "Abel" }
    last_name { "Anderson" }
  end

  factory :bruce, class: Customer do
    # id { 1 }
    first_name { "Bruce" }
    last_name { "Baker" }
  end

  # factory :invoice do
  #   status { nil }
  #   customer {association :bruce}
  # end

  factory :chris, class: Customer do
    first_name {"Chris"}
    last_name {"Christopher"}
  end

  factory :dave, class: Customer do
    first_name {"Dave"}
    last_name {"Davidson"}
  end

  factory :elliot, class: Customer do
    first_name {"Elliot"}
    last_name {"Eagle"}
  end

  factory :frank, class: Customer do
    first_name {"Frank"}
    last_name {"Fullerton"}
  end

  factory :gene, class: Customer do
    first_name {"Gene"}
    last_name {"Georges"}
  end
end