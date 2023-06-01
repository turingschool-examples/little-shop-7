require "rails_helper"

RSpec.describe "Index" do
  it "can make customers" do
    customer = create(:customer)
    puts customer.first_name
    puts customer.last_name
  end
# end
  # it "can make transactions" do
  #   transaction = create(:transaction)
  #   puts transaction.credit_card_number
  #   puts transaction.credit_card_expiration_date
  #   puts transaction.result
  # end
end