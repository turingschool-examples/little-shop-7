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
      invoice_item1 = InvoiceItem.create(status: 0)
      invoice_item2 = InvoiceItem.create(status: 1)
      invoice_item3 = InvoiceItem.create(status: 2)

      expect(invoice_item1.status).to eq("pending")
      expect(invoice_item2.status).to eq("packaged")
      expect(invoice_item3.status).to eq("shipped")
    end
  end
end
