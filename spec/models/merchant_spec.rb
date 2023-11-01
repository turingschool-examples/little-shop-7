require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many(:items) }
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  before(:each) do
    @merchant_1 = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    
  end

  describe "instance methods" do
    describe "#top_customers" do
      it "returns a list of customers with largest number of successful transactions" do
        expect(@merchant_1.top_customers).to eq()
      end
    end
  end
end