FactoryBot.define do
  factory :completed_invoice, class: "Invoice" do 
    status { 2 }
    association :customer
  end

  factory :in_progress_invoice, class: "Invoice" do 
    status { 1 }
    association :customer
  end

  factory :cancelled_invoice, class: "Invoice" do 
    status { 0 }
    association :customer
  end
end