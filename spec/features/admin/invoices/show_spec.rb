require "rails_helper"

RSpec.describe "Admin Invoices Index Page" do
  before :each do
    @invoice1 = create(:invoice) # automatically create associated customer, transactions and invoice_items
  end

  # US 33
  it "lists all of the invoice details on the show page" do
    visit admin_invoice_path(@invoice1.id)

    expect(page).to have_content("ID: ##{@invoice1.id}")
    expect(page).to have_content("Status: #{@invoice1.status}")
    expect(page).to have_content("Customer: #{@invoice1.customer.full_name}")
    expect(page).to have_content("Created Date: #{@invoice1.date_format}")
  end
end