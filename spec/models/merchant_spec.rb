require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through(:items) }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end



  describe "instance methods" do
    describe "top_five_customers" do
      it "creates an array of 5 customers" do
        
        merchant = create(:merchant)
        item = create(:item, merchant: merchant)
        customers = create_list(:customer, 20)
      
        customers.each do |customer|
          rand(1..20).times do
            invoice = create(:invoice, customer: customer)
            invoice_item = create(:invoice_item, item: item, invoice: invoice)
            transaction_results = ["success", "failed"]
            result = transaction_results.sample
            create(:transaction, result: result, invoice: invoice)
          end
        end
        top_customers = merchant.top_five_customers
      end
    end
  end

  describe "factory_bot" do
    it "exists" do
      merchant = build(:merchant, name: "Apple")
      expect(merchant.name).to eq("Apple")
    end
  end
end