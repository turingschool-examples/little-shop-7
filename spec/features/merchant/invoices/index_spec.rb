require "rails_helper"

RSpec.describe "Merchant Dashboards", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create(name: "Chucky Cheese")
    @item_1 = @merchant_1.items.create(name: "Moldy Cheese", description: "ew", unit_price: 1199, merchant_id: @merchant_1.id)
    
    @customer_1 = Customer.create(first_name: "Steve", last_name: "Minecraft")
    @invoice_1 = @customer_1.invoices.create(customer: @customer_1, created_at: 5.days.ago, status: "in progress")
    InvoiceItem.create!(invoice: @invoice_1, item: @item_1, quantity: 5, unit_price: @item_1.unit_price, status: "packaged")
  end 

  it "14. Merchant Invoices Index shows the name of the merchant" do 
    # When I visit my merchant's invoices index (/merchants/:merchant_id/invoices)
    visit "/merchants/#{@merchant_1.id}/invoices"
    # Then I see all of the invoices that include at least one of my merchant's items
    # And for each invoice I see its id
    expect(page).to have_content(@invoice_1.id)
    # And each id links to the merchant invoice show page
    click_on(@invoice_1.id.to_s)
    expect(page).to have_current_path("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
  end
end 