require "rails_helper"


RSpec.describe "the admin dashboard show" do
  before :each do
    @test_customer = Customer.create!(first_name: "Test", last_name: "Customer")
    @merchant = Merchant.create!(name: "Test Merchant")
    @item = Item.create!(name: "Test Item", description: "Test Description", unit_price: 100, merchant: @merchant)

    @incomplete_invoice1 = Invoice.create!(customer: @test_customer, created_at: 5.days.ago, status: "in progress")
    InvoiceItem.create!(invoice: @incomplete_invoice1, item: @item, status: "packaged")
  end

  it "displays the correct information for an invoice" do
    visit admin_invoice_path(@incomplete_invoice1)

    expect(page).to have_content(@incomplete_invoice1.id)
    expect(page).to have_content(@incomplete_invoice1.status)

    formatted_date = @incomplete_invoice1.created_at.strftime("%A, %B %d, %Y")
    expect(page).to have_content(formatted_date)

    expect(page).to have_content(@incomplete_invoice1.customer.first_name)
    expect(page).to have_content(@incomplete_invoice1.customer.last_name)
  end
end