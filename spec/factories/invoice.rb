FactoryBot.define do
  factory :invoice do
    association :customer
    status { [0,1,2].sample }
  end
end

# Inside RSpec file
# customer = create!(:customer)
# invoice = create!(:invoice, customer_id: customer.id)