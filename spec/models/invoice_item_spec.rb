require 'rails_helper'

describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :item_id }
    it { should validate_numericality_of :item_id }
    it { should validate_presence_of :invoice_id }
    it { should validate_numericality_of :invoice_id }
    it { should validate_presence_of :quantity }
    it { should validate_numericality_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_numericality_of :unit_price }
    it { should validate_presence_of :status }
  end

  describe "relationships" do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe "factory_bot" do
    it "exists" do
      invoice = create(:invoice)
      item = create(:item)
      invoice_item = create(:invoice_item, quantity: 1234, unit_price: 43211, invoice: invoice, item: item)
      expect(invoice_item.item.id).to eq(item.id)
      expect(invoice_item.invoice.id).to eq(invoice.id)
      expect(invoice_item.quantity).to eq(1234)
      expect(invoice_item.unit_price).to eq(43211)
    end
  end
end