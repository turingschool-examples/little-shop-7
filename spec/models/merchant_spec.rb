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
      end
    end
  end
end