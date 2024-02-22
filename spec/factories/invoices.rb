FactoryBot.define do
  factory :invoice do
    status { 0 }
    customer { association :customer }
  
    # after :create do |invoice|
    #   create_list :transaction, 3, invoice: invoice
    # end
  end
end
