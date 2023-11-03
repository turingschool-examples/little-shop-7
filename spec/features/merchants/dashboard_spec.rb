require "rails_helper"

RSpec.describe "Dashboard" do
  before :each do
    @merchant1 = create(:merchant, name: "CandyLand")
    @merchant2 = create(:merchant, name: "BeefStickCo")

    @item1 = create(:item, merchant_id: @merchant1.id)

    @customer = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)

    @invoice1 = create(:invoice, customer_id: @customer.id)
    @invoice2 = create(:invoice, customer_id: @customer2.id)
    @invoice3 = create(:invoice, customer_id: @customer3.id)
    @invoice4 = create(:invoice, customer_id: @customer4.id)
    @invoice5 = create(:invoice, customer_id: @customer5.id)

    invoice_item1 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice1.id)
    invoice_item2 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice2.id)
    invoice_item3 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice3.id)
    invoice_item4 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice4.id)
    invoice_item5 = create(:invoice_item, item_id: @item1.id, invoice_id: @invoice5.id)

    @transaction1 = create(:transaction, invoice_id: @invoice1.id)
    @transaction2 = create(:transaction, invoice_id: @invoice1.id)
    @transaction3 = create(:transaction, invoice_id: @invoice2.id)
    @transaction4 = create(:transaction, invoice_id: @invoice3.id)
    @transaction5 = create(:transaction, invoice_id: @invoice4.id)
    @transaction6 = create(:transaction, invoice_id: @invoice5.id)
    @transaction7 = create(:transaction, invoice_id: @invoice5.id)
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
    expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
    expect(page).to have_content(@item1.name)
    visit "/merchants/#{@merchant1.id}/dashboard"
    click_link("Merchant Invoices")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
    click_link("#{@invoice1.id}")
    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
    expect(page).to have_content(@invoice1.status)
  end
  
  xit "US3: has names of the top 5 customers with the count of their successful transactions" do
    # 3. Merchant Dashboard Statistics - Favorite Customers
    # As a merchant,
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see the names of the top 5 customers
    # who have conducted the largest number of successful transactions with my merchant
    # And next to each customer name I see the number of successful transactions they have
    # conducted with my merchant
    visit "/merchants/#{@merchant1.id}/dashboard"
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