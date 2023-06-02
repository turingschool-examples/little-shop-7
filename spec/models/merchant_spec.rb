require "rails_helper"

RSpec.describe Merchant, type: :model do
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
        expect(Merchant.enabled_merchants).to eq()
      end

      xit "groups merchants based on their disabled status" do
        expect(Merchant.disabled_merchants).to eq()
      end
    end
  end
end