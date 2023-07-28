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

  describe "factory_bot" do
    it "exists" do
      factory_data

      expect(@customer_1.first_name).to eq("Jimmy")
      expect(@customer_1.last_name).to eq("Pickles")
    end
  end

  describe "instance methods" do
    it "#count_transactions" do 
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      customers = create_list(:customer, 10, first_name: "pizza")

      customers[0..2].each do |customer|
        invoice = create(:invoice, customer: customer)
        invoice_item = create(:invoice_item, item: item, invoice: invoice)
        transaction = create_list(:transaction, 5, result: "success", invoice: invoice)
      end

      expect(customers.first.count_transactions).to eq(5)
    end
  end
end
