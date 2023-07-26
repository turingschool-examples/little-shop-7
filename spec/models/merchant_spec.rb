require "rails_helper"

RSpec.describe Merchant, type: :model do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    
    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
    @customer_2 = Customer.create!(first_name: "Sally", last_name: "Jones")
    @customer_3 = Customer.create!(first_name: "Tim", last_name: "Tebo")
    @customer_4 = Customer.create!(first_name: "Ronald", last_name: "McDonald")
    @customer_5 = Customer.create!(first_name: "Ralph", last_name: "Hagen")
    @customer_6 = Customer.create!(first_name: "Bill", last_name: "Salor")
    @customer_7 = Customer.create!(first_name: "Nancy", last_name: "Raegan")

    @invoice_1 = @customer_1.invoices.create!(status: "completed")
    @invoice_2 = @customer_2.invoices.create!(status: "completed")
    @invoice_3 = @customer_3.invoices.create!(status: "completed")
    @invoice_4 = @customer_4.invoices.create!(status: "completed")
    @invoice_5 = @customer_5.invoices.create!(status: "completed")
    @invoice_6 = @customer_6.invoices.create!(status: "in progress")
    @invoice_7 = @customer_7.invoices.create!(status: "cancelled")
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