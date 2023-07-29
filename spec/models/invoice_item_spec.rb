require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  it { should validate_presence_of(:invoice_id) }
  it { should validate_presence_of(:item_id) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:unit_price) }
  it { should validate_presence_of(:status) }

  it { should belong_to(:invoice) }
  it { should belong_to(:item) }
  it { should define_enum_for(:status).with_values(packaged: 0, pending: 1, shipped: 2) }

  it "returns a list of incomplete invoices" do
    completed_invoice = create(:invoice, status: 'completed')
    incomplete_invoice1 = create(:invoice, status: 'in progress')
    incomplete_invoice2 = create(:invoice, status: 'cancelled')

    create(:invoice_item, invoice: completed_invoice, status: 'shipped')
    create(:invoice_item, invoice: incomplete_invoice1, status: 'packaged')
    create(:invoice_item, invoice: incomplete_invoice2, status: 'pending')

    incomplete_invoices = InvoiceItem.incomplete_invoices

    expect(incomplete_invoices).to include(incomplete_invoice1)
    expect(incomplete_invoices).to include(incomplete_invoice2)
    expect(incomplete_invoices).not_to include(completed_invoice)
  end
end