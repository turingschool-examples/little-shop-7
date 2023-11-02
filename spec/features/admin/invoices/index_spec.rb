require "rails_helper"

RSpec.describe "Admin Invoices Index Page" do
  before :each do
    @invoice1 = create(:invoice) # automatically create associated customer, transactions and invoice_items
    @invoice2 = create(:invoice)
  end

  # US 32
  it "lists all of the invoice IDs in the system" do
    visit admin_invoices_path

    expect(page).to have_link("Invoice #{@invoice1.id.to_s}")
    expect(page).to have_link("Invoice #{@invoice2.id.to_s}")

    click_link("Invoice #{@invoice1.id.to_s}")
    
    expect(current_path).to eq(admin_invoice_path(@invoice1.id))
  end
end