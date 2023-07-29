require "rails_helper"

RSpec.describe Invoice, type: :model do
  it { should belong_to(:customer) }
  it { should have_many(:invoice_items) }
  it { should have_many(:transactions) }
  it { should have_many(:items).through(:invoice_items) }
  it { should have_many(:merchants).through(:items) }

  it "calculates the total revenue correctly" do
    invoice = create(:invoice)
    item1 = create(:item)
    item2 = create(:item)

    create(:invoice_item, invoice: invoice, item: item1, quantity: 3, unit_price: 10)
    create(:invoice_item, invoice: invoice, item: item2, quantity: 2, unit_price: 20)

    expect(invoice.total_revenue).to eq(70) 
  end
end

