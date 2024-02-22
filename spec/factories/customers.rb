FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  
    # after :create do |customer|
    #   create_list :invoice, 5, customer: customer
    # end
  end
end
