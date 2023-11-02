require "rails_helper"

RSpec.describe "Dashboard" do
  before :each do
    @merchant1 = Merchant.create!(name: "Billy")
    @merchant2 = Merchant.create!(name: "Nathan")
    @item1 = @merchant1.items.create(name: "Nathan", description: "Nathan", unit_price: 100)
    @customer = Customer.create(first_name: "Nathan", last_name: "Turing")
    @invoice1 = @customer.invoices.create(status: 1)
    InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice1.id)
  end
  it "US1: shows the name of the merchant" do
  # 1. Merchant Dashboard
  # As a merchant,
  # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
  # Then I see the name of my merchant
  visit "/merchants/#{@merchant1.id}/dashboard"
  expect(page).to have_content(@merchant1.name)
  expect(page).to_not have_content(@merchant2.name)
  end

  xit "US2: has a link to merchant items and invoices indexes" do
    # 2. Merchant Dashboard Links
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see link to my merchant items index (/merchants/:merchant_id/items)
    # And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)
    visit "/merchants/#{@merchant1.id}/dashboard"
    expect(page).to have_link("Merchant Items")
    expect(page).to have_link("Merchant Invoices")
    click_link("Merchant Items")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    click_link("#{@item1.name}")
    expect(current_path).to eq("/items/#{@item1.id}")
    expect(page).to have_content(@item1.name)
    visit "/merchants/#{@merchant1.id}/dashboard"
    click_link("Merchant Invoices")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
    click_link("#{@invoice1.id}")
    expect(current_path).to eq("/invoices/#{@invoice1.id}")
    expect(page).to have_content(@invoice1.status)
  end
end