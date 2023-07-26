require "rails_helper"

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    
    @customers = create_list(:customer, 10)
    @completed_invoices = create_list(:completed_invoice, 10)

require 'pry';binding.pry
  end
  
  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "#instance_methods" do
    describe "#top_5_customers" do
      it "can list the merchant's top 5 customers" do
        expect(@merchant_1.top_5_customers).to eq([@customer_1, @customer_2, @customer_3, @customer_4, @customer_5])
  describe "class methods" do

    let!(:little_kin_shop) { create(:merchant) }
    let!(:red_roses) { create(:merchant) }
    let!(:halloween_face) { create(:merchant) }
    let!(:tall_boy) { create(:merchant, status: 1) }
    let!(:arleen) { create(:merchant, status: 1) }
    let!(:bust_it_big) { create(:merchant, status: 1) }

    describe ".enabled_merchants" do
      it "returns an array of enabled merchants" do
        expect(Merchant.enabled_merchants).to eq([little_kin_shop, red_roses, halloween_face])
      end
    end

    describe ".disabled_merchants" do
      it "returns an array of disabled merchants" do
        expect(Merchant.disabled_merchants).to eq([tall_boy, arleen, bust_it_big])
      end
    end
  end
end