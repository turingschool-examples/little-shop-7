require "rails_helper"

RSpec.describe "Dashboard" do
  before :each do
    @merchant1 = Merchant.create!(name: "Billy")
    @merchant2 = Merchant.create!(name: "Nathan")
    @item1 = @merchant1.items.create(name: "Nathan", description: "Nathan", unit_price: 100)
    @customer = Customer.create(first_name: "Nathan", last_name: "Turing")
    @invoice1 = @customer.invoices.create(status: 1)
    InvoiceItem.create(quantity: 1, item_id: @item1.id, invoice_id: @invoice1.id)
    @customer2 = Customer.create(first_name: "Angus", last_name: "Turing")
    @invoice2 = @customer2.invoices.create(status: 1)
    InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice2.id)
    @customer3 = Customer.create(first_name: "Boyardee", last_name: "Turing")
    @invoice3 = @customer3.invoices.create(status: 1)
    InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice3.id)
    @customer4 = Customer.create(first_name: "Camoflauge", last_name: "Turing")
    @invoice4 = @customer4.invoices.create(status: 1)
    InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice4.id)
    @customer5 = Customer.create(first_name: "Derelict", last_name: "Turing")
    @invoice5 = @customer5.invoices.create(status: 1)
    InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice5.id)
    @customer6 = Customer.create(first_name: "Enmity", last_name: "Turing")
    @transaction1 = @invoice1.transactions.create(credit_card_number: 1111111111111111, credit_card_expiration_date: 01/23, result: 1)
    @transaction2 = @invoice1.transactions.create(credit_card_number: 2111111111111111, credit_card_expiration_date: 01/23, result: 1)
    @transaction3 = @invoice2.transactions.create(credit_card_number: 3111111111111111, credit_card_expiration_date: 01/23, result: 1)
    @transaction4 = @invoice3.transactions.create(credit_card_number: 4111111111111111, credit_card_expiration_date: 01/23, result: 1)
    @transaction5 = @invoice4.transactions.create(credit_card_number: 5111111111111111, credit_card_expiration_date: 01/23, result: 1)
    @transaction6 = @invoice5.transactions.create(credit_card_number: 6111111111111111, credit_card_expiration_date: 01/23, result: 1)
    @transaction7 = @invoice5.transactions.create(credit_card_number: 7111111111111111, credit_card_expiration_date: 01/23, result: 1)


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

  it "US2: has a link to merchant items and invoices indexes" do
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
  it "US3: has names of the top 5 customers with the count of their successful transactions" do
    # 3. Merchant Dashboard Statistics - Favorite Customers
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    # And next to each customer name I see the number of successful transactions they have
    # conducted with my merchant
    visit "/merchants/#{@merchant1.id}/dashboard"
    #require 'pry'; binding.pry
    expect(page).to have_content("Angus")
    expect(page).to have_content("Boyardee")
    expect(page).to have_content("Camoflauge")
    expect(page).to have_content("Derelict")
    expect(page).to have_content("Nathan")
    expect(page).to have_content(2)
    expect(page).to have_content(1)
    expect(page).to_not have_content("Enmity")
    expect(page).to_not have_content(0)
  end
end