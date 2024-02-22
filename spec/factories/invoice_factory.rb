FactoryBot.define do
  factory :invoice do
    status { "success" }
    customer
  end

  factory :failed_invoice do
    status { "failed" }
    customer
  end
end
