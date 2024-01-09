require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe "associations" do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe "enums" do
    it "has an enum for status" do
      place = Merchant.create!(name: "Place")
      bob = Customer.create!(first_name: "Bob", last_name: "Smith")
      item1 = place.items.create!(name: "Item 1", description: "Item 1 description", unit_price: 100)

      invoice1 = bob.invoices.create!(status: 0) # Assuming status 0 is valid for Invoice

      invoice_item1 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 243, unit_price: 24342, status: 0)
      invoice_item2 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 245, unit_price: 243442, status: 1)
      invoice_item3 = InvoiceItem.create!(item: item1, invoice: invoice1, quantity: 23, unit_price: 2442, status: 2)

      expect(invoice_item1.pending?).to be true
      expect(invoice_item2.packaged?).to be true
      expect(invoice_item3.shipped?).to be true
    end
  end
end
