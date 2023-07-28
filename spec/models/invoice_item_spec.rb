require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe "#instance_methods" do
    describe "#format_selling_price" do
      it "converts unit_price in cents to dollars" do
        merchant = FactoryBot.create(:merchant)
        customer = FactoryBot.create(:customer)
        invoice = FactoryBot.create(:invoice, customer: customer)
        item = FactoryBot.create(:item, merchant: merchant)
        
        invoice_item = InvoiceItem.create!(quantity: 8, unit_price: 90210, status: "pending", invoice_id: invoice.id, item_id: item.id)

        formatted_price = invoice_item.format_selling_price

        expect(formatted_price).to eq("$902.10")
      end
    end
  end
end