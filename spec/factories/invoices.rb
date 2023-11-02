require 'faker'

FactoryBot.define do
  factory :invoice do
    association :customer # automatically create a customer record when an invoice is created using factory bc of the foreign key association

    status { Invoice.statuses.keys.sample } # Randomly pick one of the status keys from enum

    after(:create) do |invoice|
      # Optionally create some related records after the invoice is created
      create_list(:transaction, 3, invoice: invoice)
      create_list(:invoice_item, 3, invoice: invoice)
    end
  end
end
