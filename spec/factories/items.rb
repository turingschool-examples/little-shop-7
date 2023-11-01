require "faker"

FactoryBot.define do
  factory :item do
    status 0
    association :merchant
  end
end