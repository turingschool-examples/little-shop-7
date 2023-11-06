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
  it "US4: has section for 'items ready to ship'" do
    # 4. Merchant Dashboard Items Ready to Ship
    # As a merchant
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # Then I see a section for "Items Ready to Ship"
    # In that section I see a list of the names of all of my items that
    # have been ordered and have not yet been shipped,
    # And next to each Item I see the id of the invoice that ordered my item
    # And each invoice id is a link to my merchant's invoice show page
    @customer0 = Customer.create(first_name: "Angus", last_name: "Turing")
    @invoice0 = @customer0.invoices.create(status: 1)

    @item2 = @merchant1.items.create(name: "Bat", description: "Bat", unit_price: 200)
    @item3 = @merchant1.items.create(name: "Cat", description: "Cat", unit_price: 300)
    @item4 = @merchant1.items.create(name: "Rat", description: "Rat", unit_price: 400)

    @transaction0 = @invoice0.transactions.create(credit_card_number: 1234, credit_card_expiration_date: 01/11, result: 1)

    @ii1 = create(:invoice_item, item: @item2, invoice: @invoice0, status: 0)
    @ii2 = create(:invoice_item, item: @item3, invoice: @invoice0, status: 1)
    @ii3 = create(:invoice_item, item: @item4, invoice: @invoice0, status: 2)


    visit "/merchants/#{@merchant1.id}/dashboard"
    expect(page).to have_content("Items Ready to Ship")
    within("#Items-Ready-to-Ship") do
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)
      expect(page).to_not have_content(@item4.name)
    end
    within("#Items-Ready-to-Ship") do
      expect(page).to have_content(@invoice0.id)
    end
    click_link("#{@invoice0.id}", match: :first)
    expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@invoice0.id}")
  end
  it "US5: in the section for 'items ready to ship' I see date invoice was created formatted like 'Monday, July 18, 2019' and ordered oldest to newest" do
    # 5. Merchant Dashboard Invoices sorted by least recent
    # As a merchant
    # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
    # In the section for "Items Ready to Ship",
    # Next to each Item name I see the date that the invoice was created
    # And I see the date formatted like "Monday, July 18, 2019"
    # And I see that the list is ordered from oldest to newest
    @customer0 = Customer.create(first_name: "Angus", last_name: "Turing")
    @invoice0 = @customer0.invoices.create(status: 1)
    @invoice7 = @customer0.invoices.create(status: 1)

    @item2 = @merchant1.items.create(name: "Bat", description: "Bat", unit_price: 200)
    @item3 = @merchant1.items.create(name: "Cat", description: "Cat", unit_price: 300)
    @item4 = @merchant1.items.create(name: "Rat", description: "Rat", unit_price: 400)

    @transaction0 = @invoice0.transactions.create(credit_card_number: 1234, credit_card_expiration_date: 01/11, result: 1)
    @transaction7 = @invoice0.transactions.create(credit_card_number: 1234, credit_card_expiration_date: 01/11, result: 1)


    @ii1 = create(:invoice_item, item: @item2, invoice: @invoice0, status: 0)
    @ii2 = create(:invoice_item, item: @item3, invoice: @invoice0, status: 1)
    @ii3 = create(:invoice_item, item: @item4, invoice: @invoice0, status: 2)
    @ii7 = create(:invoice_item, item: @item3, invoice: @invoice0, status: 2)

    @invoice0.update(created_at: '1999-01-01 00:00:00')
    date = Date.today.strftime('%A, %B %d, %Y')

    visit "/merchants/#{@merchant1.id}/dashboard"
    save_and_open_page
    expect(page).to have_content("Items Ready to Ship")
    within("#Items-Ready-to-Ship") do
      expect(page).to have_content("Date: Friday, January 01, 1999")
      
      expect(page).to have_content("Date: #{date}")
      expect("Date: Friday, January 01, 1999").to appear_before("Date: #{date}")
    end
  end
end