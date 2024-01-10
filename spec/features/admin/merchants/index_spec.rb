require "rails_helper"

RSpec.describe "Merchants Index Page" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "John")
    @merchant_2 = Merchant.create!(name: "Jacob")
    @merchant_3 = Merchant.create!(name: "Jingleheimer")
    @merchant_4 = Merchant.create!(name: "Schmidt")
    @merchant_5 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_6 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_7 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_8 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_9 = Merchant.create!(name: Faker::Name.first_name)
    @merchant_10 = Merchant.create!(name: Faker::Name.first_name)
  end

  describe "User Story 24" do
    it "displays the name of each merchant in the system" do
      visit admin_merchants_path

      expect(page).to have_content("John")
      expect(page).to have_content("Jacob")
      expect(page).to have_content("Jingleheimer")
      expect(page).to have_content("Schmidt")
    end
  end

  describe "User Story 27" do
    it "has a button to enable or disable every Merchant next to their name" do
      visit admin_merchants_path

      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_button("Enable Merchant")
        expect(page).to have_no_button("Disable Merchant")
        click_button("Enable Merchant")
        expect(page).to have_button("Disable Merchant")
      end

      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_button("Enable Merchant")
      end

      within "#merchant-#{@merchant_3.id}" do
        expect(page).to have_button("Enable Merchant")
      end

      within "#merchant-#{@merchant_4.id}" do
        expect(page).to have_button("Enable Merchant")
        expect(page).to have_no_button("Disable Merchant")
        click_button ("Enable Merchant")
        expect(page).to have_button("Disable Merchant")
      end
    end
  end

  describe "User Story 28" do
    it "has separate sections for Enabled Merchants and Disabled Merchants" do
      merchant_11 = Merchant.create!(name: "Jack", status: "enabled")
      merchant_12 = Merchant.create!(name: "Jill", status: "enabled")

      visit admin_merchants_path

      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content("Disabled Merchants")

      within "#enabled-merchants" do
        expect(page).to have_content("Jack")
        expect(page).to have_content("Jill")
      end

      within "#disabled-merchants" do
        expect(page).to have_content("John")
        expect(page).to have_content("Jacob")
        expect(page).to have_content("Jingleheimer")
      end
    end
  end

  describe "User Story 29" do
    it "has a link that lets you create a new merchant" do
      visit admin_merchants_path

      expect(page).to have_no_content("Johnny")
      expect(page).to have_link("New Merchant")

      click_link("New Merchant")

      expect(page.current_path).to eq(new_admin_merchant_path)
      fill_in("merchant_name", with: "Johnny")
      click_button("Submit")

      expect(page.current_path).to eq(admin_merchants_path)

      within "#disabled-merchants" do
        expect(page).to have_content("Johnny")
      end
    end
  end

  describe "User Story 30" do
    it "displays the top 5 merchants by total revenue generated" do
      hat = Item.create!(name: "Hat", description: "Makes the wearer look fancy", unit_price: 15000, merchant_id: @merchant_1.id)
      shirt = Item.create!(name: "Shirt", description: "Makes the wearer look kind", unit_price: 5000, merchant_id: @merchant_2.id)
      pants = Item.create!(name: "Pants", description: "Makes the wearer look strong", unit_price: 20000, merchant_id: @merchant_3.id)
      dress = Item.create!(name: "Dress", description: "Makes the wearer look delicate", unit_price: 25000, merchant_id: @merchant_4.id)
      socks = Item.create!(name: "Socks", description: "Makes the wearer smell nice", unit_price: 5000, merchant_id: @merchant_4.id)
      shoes = Item.create!(name: "Shoes", description: "Makes the wearer look successful", unit_price: 20000, merchant_id: @merchant_5.id)
      tie = Item.create!(name: "Tie", description: "Makes the wearer look old", unit_price: 10000, merchant_id: @merchant_5.id)
      watch = Item.create!(name: "Watch", description: "Makes the wearer look reliable", unit_price: 15000, merchant_id: @merchant_2.id)
      shorts = Item.create!(name: "Shorts", description: "Makes the wearer look relaxed", unit_price: 5000, merchant_id: @merchant_3.id)
      jacket = Item.create!(name: "Jacket", description: "Makes the wearer look stuffy", unit_price: 20000, merchant_id: @merchant_4.id)

      Item.all.each do |item|
        create(:invoice_item, item_id: item.id, quantity: 1)
      end

      InvoiceItem.all.each do |invoice_item|
        create(:invoice, id: invoice_item.item_id)
      end

      Invoice.all.each do |invoice|
        create(:transaction, result: "success", invoice_id: invoice.id)
      end

      visit admin_merchants_path

      expect(page).to have_content("Top Merchants")
      within "#top-merchants" do
        expect(@merchant_4.name).to appear_before(@merchant_5.name)
        expect(@merchant_5.name).to appear_before(@merchant_3.name)
        expect(@merchant_3.name).to appear_before(@merchant_2.name)
        expect(@merchant_2.name).to appear_before(@merchant_1.name)
      end
    end

    it "has the total revenue generated for each merchant listed, and a link to each merchant's admin show page" do
      hat = Item.create!(name: "Hat", description: "Makes the wearer look fancy", unit_price: 15000, merchant_id: @merchant_1.id)
      shirt = Item.create!(name: "Shirt", description: "Makes the wearer look kind", unit_price: 5000, merchant_id: @merchant_2.id)
      pants = Item.create!(name: "Pants", description: "Makes the wearer look strong", unit_price: 20000, merchant_id: @merchant_3.id)
      dress = Item.create!(name: "Dress", description: "Makes the wearer look delicate", unit_price: 25000, merchant_id: @merchant_4.id)
      socks = Item.create!(name: "Socks", description: "Makes the wearer smell nice", unit_price: 5000, merchant_id: @merchant_4.id)
      shoes = Item.create!(name: "Shoes", description: "Makes the wearer look successful", unit_price: 20000, merchant_id: @merchant_5.id)
      tie = Item.create!(name: "Tie", description: "Makes the wearer look old", unit_price: 10000, merchant_id: @merchant_5.id)
      watch = Item.create!(name: "Watch", description: "Makes the wearer look reliable", unit_price: 15000, merchant_id: @merchant_2.id)
      shorts = Item.create!(name: "Shorts", description: "Makes the wearer look relaxed", unit_price: 5000, merchant_id: @merchant_3.id)
      jacket = Item.create!(name: "Jacket", description: "Makes the wearer look stuffy", unit_price: 20000, merchant_id: @merchant_4.id)

      Item.all.each do |item|
        create(:invoice_item, item_id: item.id, quantity: 1)
      end

      InvoiceItem.all.each do |invoice_item|
        create(:invoice, id: invoice_item.item_id)
      end

      Invoice.all.each do |invoice|
        create(:transaction, result: "success", invoice_id: invoice.id)
      end

      visit admin_merchants_path

      within "#top-merchant-#{@merchant_1.id}" do
        expect(page).to have_content("150.00 in sales")
        expect(page).to have_link(nil, href: admin_merchant_path(@merchant_1.id))
      end

      within "#top-merchant-#{@merchant_2.id}" do
        expect(page).to have_content("$200.00 in sales")
        expect(page).to have_link(nil, href: admin_merchant_path(@merchant_2.id))
      end

      within "#top-merchant-#{@merchant_3.id}" do
        expect(page).to have_content("$250.00 in sales")
        expect(page).to have_link(nil, href: admin_merchant_path(@merchant_3.id))
      end

      within "#top-merchant-#{@merchant_4.id}" do
        expect(page).to have_content("$500.00 in sales")
        expect(page).to have_link(nil, href: admin_merchant_path(@merchant_4.id))
      end

      within "#top-merchant-#{@merchant_5.id}" do
        expect(page).to have_content("$300.00 in sales")
        expect(page).to have_link(nil, href: admin_merchant_path(@merchant_5.id))
      end
    end
  end
end
