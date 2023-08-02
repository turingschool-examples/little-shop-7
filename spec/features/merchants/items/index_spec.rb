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

    # us_12
  end
  describe "I see the names of the top 5 most popular items ranked by total revenue generated" do
    before :each do
    @merchant = create(:merchant)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @item_3 = create(:item, merchant: @merchant)
    @item_4 = create(:item, merchant: @merchant)
    @item_5 = create(:item, merchant: @merchant)

    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_1)
    @invoice_3 = create(:invoice, customer: @customer_1)
    @invoice_4 = create(:invoice, customer: @customer_2)
    @invoice_5 = create(:invoice, customer: @customer_2)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, status: 2, quantity: 6, unit_price: 1000)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, status: 2, quantity: 5, unit_price: 1000)
    @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, status: 2, quantity: 4, unit_price: 1000)
    @invoice_item_4 = create(:invoice_item, item: @item_4, invoice: @invoice_4, status: 2, quantity: 3, unit_price: 1000)
    @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_5, status: 2, quantity: 2, unit_price: 1000)
    @invoice_item_6 = create(:invoice_item, item: @item_5, invoice: @invoice_1, status: 2, quantity: 1, unit_price: 1000)
    @invoice_item_7 = create(:invoice_item, item: @item_4, invoice: @invoice_2, status: 2, quantity: 1, unit_price: 1000)
    @invoice_item_8 = create(:invoice_item, item: @item_3, invoice: @invoice_3, status: 2, quantity: 2, unit_price: 1000)
    @invoice_item_9 = create(:invoice_item, item: @item_2, invoice: @invoice_4, status: 2, quantity: 3, unit_price: 1000)
    @invoice_item_10 = create(:invoice_item, item: @item_1, invoice: @invoice_5, status: 2, quantity: 4, unit_price: 1000)

    @transaction_1 = create(:transaction, invoice: @invoice_1, result: "failed")
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: "failed")
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: "failed")
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: "failed")
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: "failed")
    @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success")
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: "success")
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: "success")
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: "success")
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: "success")
    end
    it "And I see that each item name links to my merchant item show page for that item" do

      visit merchant_items_path(@merchant)
      
      within (".most_popular_items") do
        expect(@item_1.name).to appear_before(@item_2.name)
        expect(@item_2.name).to appear_before(@item_3.name)
        expect(@item_3.name).to appear_before(@item_4.name)
        expect(@item_4.name).to appear_before(@item_5.name)
      end
    end

    it "And I see the total revenue generated next to each item name" do
      visit merchant_items_path(@merchant)

      within (".most_popular_items") do
        expect(page).to have_content("Total Revenue: $6000")
        expect(page).to have_content("Total Revenue: $4000")
        expect(page).to have_content("Total Revenue: $3000")
      end
    end
  end
    #   13. Merchant Items Index: Top Item's Best Day

    # As a merchant
    # When I visit my items index page
    # Then next to each of the 5 most popular items I see the date with the most sales for each item.
    # And I see a label “Top selling date for <item name> was <date with most sales>"

    # Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
  describe "Merchant Items Index Page, top items best day" do 
    before :each do
      @merchant = create(:merchant)
  
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
  
      @item_1 = create(:item, merchant: @merchant)
      @item_2 = create(:item, merchant: @merchant)
      @item_3 = create(:item, merchant: @merchant)
      @item_4 = create(:item, merchant: @merchant)
      @item_5 = create(:item, merchant: @merchant)
  
      @invoice_1 = create(:invoice, customer: @customer_1, created_at: "2012-03-25 09:54:09 UTC")
      @invoice_2 = create(:invoice, customer: @customer_1, created_at: "2012-03-28 09:54:09 UTC")
      @invoice_3 = create(:invoice, customer: @customer_1, created_at: "2013-03-28 09:54:09 UTC")
      @invoice_4 = create(:invoice, customer: @customer_2, created_at: "2014-03-28 09:54:09 UTC")
      @invoice_5 = create(:invoice, customer: @customer_2, created_at: "2015-03-28 09:54:09 UTC")
  
      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, status: 2, quantity: 6, unit_price: 1000)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, status: 2, quantity: 5, unit_price: 1000)
      @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, status: 2, quantity: 4, unit_price: 1000)
      @invoice_item_4 = create(:invoice_item, item: @item_4, invoice: @invoice_4, status: 2, quantity: 3, unit_price: 1000)
      @invoice_item_5 = create(:invoice_item, item: @item_5, invoice: @invoice_5, status: 2, quantity: 2, unit_price: 1000)
      @invoice_item_6 = create(:invoice_item, item: @item_5, invoice: @invoice_1, status: 2, quantity: 1, unit_price: 1000)
      @invoice_item_7 = create(:invoice_item, item: @item_4, invoice: @invoice_2, status: 2, quantity: 1, unit_price: 1000)
      @invoice_item_8 = create(:invoice_item, item: @item_3, invoice: @invoice_3, status: 2, quantity: 2, unit_price: 1000)
      @invoice_item_9 = create(:invoice_item, item: @item_2, invoice: @invoice_4, status: 2, quantity: 3, unit_price: 1000)
      @invoice_item_10 = create(:invoice_item, item: @item_1, invoice: @invoice_5, status: 2, quantity: 4, unit_price: 1000)
  
      @transaction_1 = create(:transaction, invoice: @invoice_1, result: "failed")
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: "failed")
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: "failed")
      @transaction_4 = create(:transaction, invoice: @invoice_4, result: "failed")
      @transaction_5 = create(:transaction, invoice: @invoice_5, result: "failed")
      @transaction_1 = create(:transaction, invoice: @invoice_1, result: "success")
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: "success")
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: "success")
      @transaction_4 = create(:transaction, invoice: @invoice_4, result: "success")
      @transaction_5 = create(:transaction, invoice: @invoice_5, result: "success")
      end
    describe "I visit my merchant items index page" do
      it "Then next to each of the 5 most popular items I see the date with the most sales for each item" do
        visit merchant_items_path(@merchant)

        within (".most_popular_items") do
          expect(page).to have_content("Top selling date for #{@item_1} was 2012-03-25")
        end
      end
    end
  end
end
