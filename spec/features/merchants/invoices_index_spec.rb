require "rails_helper"

RSpec.describe "the merchant invoices index" do
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

  it "lists all invoices that include at least one of a given merchant's items" do
    # When I visit my merchant's invoices index (/merchants/:merchant_id/invoices)
    visit "/merchants/#{@merchant_1.id}/invoices"

    save_and_open_page

    # Then I see all of the invoices that include at least one of my merchant's items
    # And for each invoice I see its id
    expect(page).to have_link("Invoice ##{@invoice_1.id}")
    expect(page).to have_link("Invoice ##{@invoice_2.id}")

    # And each id links to the merchant invoice show page
    click_link("Invoice ##{@invoice_1.id}")

    expect(current_path).to eq("/invoices/#{@invoice_1.id}")

    click_link("Invoice ##{@invoice_2.id}")

    expect(current_path).to eq("/invoices/#{@invoice_2.id}")
  end
end