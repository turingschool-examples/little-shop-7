require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "assocations" do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values([:pending, :packaged, :shipped]) }
  end

  describe "methods" do
    it "formats unit price" do
      @item = create(:item)
      @invoice = create(:invoice)
      @invoice_item_1 = create(:invoice_item, unit_price: 1000)
      @invoice_item_2 = create(:invoice_item, unit_price: 900)

      expect(@invoice_item_1.format_unit_price).to eq("$10.00")
      expect(@invoice_item_2.format_unit_price).to eq("$9.00")
    end
  end
end
