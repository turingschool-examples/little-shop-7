require "rails_helper"

RSpec.describe "the merchant invoices show page" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)

    @customer_1 = create(:customer)
    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id)

    @invoice_item_1 = InvoiceItem.create(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 100, status: "packaged")
    @invoice_item_2 = InvoiceItem.create(item_id: @item_1.id, invoice_id: @invoice_2.id, quantity: 5, unit_price: 100, status: "packaged")
  end

  it "displays information about a given invoice" do
    visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

    expect(page).to have_content("Invoice ##{@invoice_1.id}")
    expect(page).to have_content("Status: #{@invoice_1.status.titleize}")
    expect(page).to have_content("Created on: #{@invoice_1.format_created_date}")
    expect(page).to have_content("Customer: #{@invoice_1.customer.full_name}")
  end

end