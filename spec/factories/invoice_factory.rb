require 'faker'

FactoryBot.define do
   factory :invoice do
      status { Faker::Number.between(from: 0, to: 2) }
      association :customer
      after :create do |invoice|
         create :transaction, invoice: invoice
      end
   end
end