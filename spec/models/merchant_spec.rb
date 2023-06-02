require "rails_helper"

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant_1 = create(:merchant, status: 0)
    @merchant_2 = create(:merchant, status: 0)
    @merchant_3 = create(:merchant, status: 1)
    @merchant_4 = create(:merchant, status: 1)
    @merchant_5 = create(:merchant, status: 1)
  end
  describe "Relationships" do
    it { should have_many(:items)}
    it { should have_many(:invoice_items).through(:items)}
    it { should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:customers).through(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
  end

  describe "Validations" do
    it { should validate_presence_of :name }
  end

  describe "Class Methods" do
    describe ".enabled_merchants" do
      it "groups merchants based on their enabled status" do
        expect(Merchant.enabled_merchants).to eq([@merchant_3, @merchant_4, @merchant_5])
      end

      it "groups merchants based on their disabled status" do
        expect(Merchant.disabled_merchants).to eq([@merchant_1, @merchant_2])
      end
    end
  end
end