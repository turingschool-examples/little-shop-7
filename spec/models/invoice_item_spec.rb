require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do 
  describe 'relationships' do 
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe "#price_to_currency" do
    it "returns a price in currency format" do
      customer = Customer.create!(first_name: "Teddy", last_name: "Handyman")
      merchant = Merchant.create!(name: "Bob's Burgers")
      item = Item.create!(name: "Burger", description: "Delicious", unit_price: 1000, merchant_id: merchant.id)
      invoice = Invoice.create!(customer: customer, status: 1)
      invoice_item = InvoiceItem.create!(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 1000, status: 1)

      expect(invoice_item.price_to_currency).to eq("$10.00")
    end
  end
end
