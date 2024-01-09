RSpec.describe "the admin invoices index" do
  before :each do
    @test_customer = Customer.create!(first_name: "Test", last_name: "Customer")
    @merchant = Merchant.create!(name: "Test Merchant")
    @item = Item.create!(name: "Test Item", description: "Test Description", unit_price: 100, merchant: @merchant)
  
    @incomplete_invoice1 = Invoice.create!(customer: @test_customer, created_at: 5.days.ago, status: "in progress")
    InvoiceItem.create!(invoice: @incomplete_invoice1, item: @item, status: "packaged")
    @incomplete_invoice2 = Invoice.create!(customer: @test_customer, created_at: 3.days.ago, status: "in progress")
    InvoiceItem.create!(invoice: @incomplete_invoice2, item: @item, status: "pending")
    @incomplete_invoice3 = Invoice.create!(customer: @test_customer, created_at: 1.day.ago, status: "in progress")
    InvoiceItem.create!(invoice: @incomplete_invoice3, item: @item, status: "pending")
    @complete_invoice = Invoice.create!(customer: @test_customer, created_at: 1.day.ago, status: "completed")
    InvoiceItem.create!(invoice: @complete_invoice, item: @item, status: "shipped")
  end

  it "shows all invoce ids as links to invoice show" do
    visit admin_invoices_path

    expect(page).to have_link(@incomplete_invoice1.id, href: admin_invoice_path(@incomplete_invoice1))
    expect(page).to have_link(@incomplete_invoice2.id, href: admin_invoice_path(@incomplete_invoice2))
    expect(page).to have_link(@incomplete_invoice3.id, href: admin_invoice_path(@incomplete_invoice3))
    expect(page).to have_link(@complete_invoice.id, href: admin_invoice_path(@complete_invoice))
  end
end
