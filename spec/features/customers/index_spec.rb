require "rails_helper"

RSpec.describe "Index" do
  it "can make customers" do
    customer = create(:customer)
    puts customer.first_name
    puts customer.last_name
  end
end