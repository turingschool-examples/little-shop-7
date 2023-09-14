require "rails_helper"

# RSpec.describe Customer do
RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
  end

  describe "has custom methods" do
    before(:each) do
      load_test_data
    end

    it "can display top customers" do
      expect(Customer.top_customers).to eq([@customer_1, @customer_4, @customer_2, @customer_3, @customer_5])
    end
  end
end