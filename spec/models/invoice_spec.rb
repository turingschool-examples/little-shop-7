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

  it "tests timestamp to date method" do
  customer = create(:customer)
  invoice = customer.invoices.create!(status: "cancelled", created_at: DateTime.new(2024, 1, 7, 15, 11, 43, '+0'))

  expect(invoice.format_created_at).to eq("Sunday, January 07, 2024")
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
end
