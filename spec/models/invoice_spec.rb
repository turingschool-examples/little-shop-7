require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "assocations" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many :items }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values([:"in progress", :completed, :cancelled]) }
  end

  describe "methods" do
    it "formats created_at date" do
      @customer = create(:customer)
      @invoice = create(:invoice, created_at: "2019-07-18 00:00:00")
    
      expect(@invoice.format_created_date).to eq("Thursday, July 18, 2019")
    end
  end

  it "calculates the total revenue" do
    item_1 = create(:item, unit_price: 1)
    item_2 = create(:item, unit_price: 2)
    item_3 = create(:item, unit_price: 3)

    invoice = create(:invoice)

    invoice_item_1 = create(:invoice_item, quantity: 3, invoice: invoice, item: item_1)
    invoice_item_2 = create(:invoice_item, quantity: 2, invoice: invoice, item: item_2)
    invoice_item_3 = create(:invoice_item, quantity: 1, invoice: invoice, item: item_3)

    expect(invoice.total_revenue).to eq(10)
  end

  it "calculates the total revenue by merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    item_3 = create(:item, merchant_id: merchant_1.id)

    customer_1 = create(:customer)
    invoice_1 = create(:invoice, customer_id: customer_1.id)

    invoice_item_1 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 2, unit_price: 100)
    invoice_item_2 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_2.id, quantity: 2, unit_price: 200)
    invoice_item_3 = create(:invoice_item, invoice_id: invoice_1.id, item_id: item_3.id, quantity: 3, unit_price: 100)

    expect(invoice_1.total_revenue_by_merchant(merchant_1)).to eq("5.00")
    expect(invoice_1.total_revenue_by_merchant(merchant_2)).to eq("4.00")
  end
end
