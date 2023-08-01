require "rails_helper"

RSpec.describe "As a merchant" do
  describe "When I visit my items index page" do
    it "Then next to each item I see a button to disable or enable that item" do
      merchant = create(:merchant)
      items = create_list(:item, 4, merchant: merchant)

      visit merchant_items_path(merchant)
      
        items.each do |item|
          expect(page).to have_css("##{item.id}_button")
      end
    end
    
    it "When I click this button, Then I am redirected back to the items index page where I see the item's status has changed" do
      merchant = create(:merchant)
      items = create_list(:item, 4, merchant: merchant)

      visit "/merchants/#{merchant.id}/items" 
      
      find_button("Enable", id: "#{items.first.id}_button")      

      click_button "Enable", id: "#{items.first.id}_button"

      expect(current_path).to eq("/merchants/#{merchant.id}/items")
      expect(page).to have_no_button("Enable", id: "#{items.first.id}_button")
      expect(page).to have_button("Disable", id: "#{items.first.id}_button")
    end

    it "Then I see two sections, one for 'Enabled Items' and one for 'Disabled Items'" do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant, status: true)
      item_2 = create(:item, merchant: merchant, status: false)
      item_3 = create(:item, merchant: merchant, status: true)
      item_4 = create(:item, merchant: merchant, status: false)
      item_5 = create(:item, merchant: merchant, status: true)
      item_6 = create(:item, merchant: merchant, status: false)
      item_7 = create(:item, merchant: merchant, status: true)
      item_8 = create(:item, merchant: merchant, status: false)

      visit merchant_items_path(merchant)

      within (".enabled_items") do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_3.name)
        expect(page).to have_content(item_5.name)
        expect(page).to have_content(item_7.name)
      end
    
      within (".disabled_items") do 
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_4.name)
        expect(page).to have_content(item_6.name)
        expect(page).to have_content(item_8.name)
      end
    end
    #US 11
    it "I see a link to create a new item, When I click on this link and I see a form that allows me to add item info" do
      merchant = create(:merchant)  
      items = create_list(:item, 4, merchant: merchant)
      items << create_list(:item, 4, merchant: merchant, status: false)

      visit merchant_items_path(merchant)

      expect(page).to have_link("Create New Item", href: "#{new_merchant_item_path(merchant)}")

      click_link("Create New Item")
      
      expect(current_path).to eq("#{new_merchant_item_path(merchant)}")
      expect(page).to have_css("#new_item_form")
    end

    it "When I fill out the form I click Submit then I am taken back to the items index page and I see the item I just created displayed in the list of items" do
      merchant = create(:merchant)  
      items = create_list(:item, 4, merchant: merchant)
      items << create_list(:item, 4, merchant: merchant, status: false)

      visit new_merchant_item_path(merchant)

      fill_in(:name, with: "African Bullfrog")
      fill_in(:description, with: "A furious father")
      fill_in(:unit_price, with: 50000000)

      click_button("Create Item")

      expect(current_path).to eq("#{merchant_items_path(merchant)}")
      
      within (".disabled_items") do
        expect(page).to have_content("African Bullfrog")
      end

      expect(merchant.items.last.status).to eq(false)
    end

    #     12. Merchant Items Index: 5 most popular items

    # As a merchant
    # When I visit my items index page
    # Then I see the names of the top 5 most popular items ranked by total revenue generated
    # And I see that each item name links to my merchant item show page for that item
    # And I see the total revenue generated next to each item name

    # Notes on Revenue Calculation:
    # - Only invoices with at least one successful transaction should count towards revenue
    # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
    # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
  end
  describe "I see the names of the top 5 most popular items ranked by total revenue generated" do
    @merchant = create(:merchant)

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @item_4 = create(:item, merchant: @merchant)
    @item_5 = create(:item, merchant: @merchant)

    @invoice_1 = create(:invoice, merchant: @merchant)
    @invoice_2 = create(:invoice, merchant: @merchant)
    @invocie_3 = create(:invoice, merchant: @merchant)
    @invoice_4 = create(:invoice, merchant: @merchant)
    @invoice_5 = create(:invoice, merchant: @merchant)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, status: 2, quantity: 1, unit_price: 1000)
    @invoice_item_2
    it "And I see that each item name links to my merchant item show page for that item" do

      visit merchant_items_path(@merchant)
    end
  end
end
