require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "validations" do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe "relationships" do
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "#top_five" do
    it "should return the top five customers and their transaction numbers" do
      test_data
      top_customers = Customer.top_customers
      expect(top_customers.length).to eq(5)
      expect(top_customers.first.full_name).to eq("Joey Ondricka")
      expect(top_customers.first.successful_transactions_count).to eq(4)
    end
  end

  describe "factory_bot" do
    it "exists" do
      customer = build(:customer, first_name: "Jimmy", last_name: "Pickles")
      expect(customer.first_name).to eq("Jimmy")
      expect(customer.last_name).to eq("Pickles")

    end
  end
end
