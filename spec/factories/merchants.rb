FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    status { 0 }

    # after :create do |merchant|
    #   create_list :item, 5, merchant: merchant
    # end
  end
end
