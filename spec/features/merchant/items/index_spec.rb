require "rails_helper"

RSpec.describe "items index page", :vcr do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    @merchant_2 = Merchant.create!(name: "John Johnson", status: nil)
    @item_1 = @merchant_1.items.create!(name: "Ball", description: "round", unit_price: 75106, status: 1)
    @item_2 = @merchant_1.items.create!(name: "Disc", description: "flat", unit_price: 75103, status: 1)
    @item_3 = @merchant_2.items.create!(name: "Pants", description: "soft", unit_price: 65104, status: 1)
    @item_4 = @merchant_1.items.create!(name: "Stick", description: "long", unit_price: 30100, status: 0)
    @item_5 = @merchant_1.items.create!(name: "Hat", description: "stylish", unit_price: 45000, status: 1)
    @item_6 = @merchant_1.items.create!(name: "Shirt", description: "casual", unit_price: 30000, status: 1)
    @item_7 = @merchant_1.items.create!(name: "Glasses", description: "trendy", unit_price: 50000, status: 1)

    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, quantity: 10, unit_price: 1000)
    @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, quantity: 8, unit_price: 1500)
    @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, quantity: 5, unit_price: 2000)
    @invoice_item_4 = FactoryBot.create(:invoice_item, item: @item_4, quantity: 3, unit_price: 3000)
    @invoice_item_5 = FactoryBot.create(:invoice_item, item: @item_5, quantity: 15, unit_price: 1200)
    @invoice_item_6 = FactoryBot.create(:invoice_item, item: @item_6, quantity: 12, unit_price: 1800)
    @invoice_item_7 = FactoryBot.create(:invoice_item, item: @item_7, quantity: 8, unit_price: 2200)

    @transaction_1 = FactoryBot.create(:transaction, invoice: @invoice_item_1.invoice, result: 0)
    @transaction_2 = FactoryBot.create(:transaction, invoice: @invoice_item_2.invoice, result: 0)
    @transaction_3 = FactoryBot.create(:transaction, invoice: @invoice_item_3.invoice, result: 0)
    @transaction_4 = FactoryBot.create(:transaction, invoice: @invoice_item_4.invoice, result: 0)
    @transaction_5 = FactoryBot.create(:transaction, invoice: @invoice_item_5.invoice, result: 0)
    @transaction_6 = FactoryBot.create(:transaction, invoice: @invoice_item_6.invoice, result: 0)
    @transaction_7 = FactoryBot.create(:transaction, invoice: @invoice_item_7.invoice, result: 0)
  end

# As a merchant,
# When I visit my merchant items index page 
# (merchants/:merchant_id/items)
# I see a list of the names of all of my items
# And I do not see items for any other merchant

  describe " when i visit my merchants item index page" do
    it "displays a list of the names of all my items" do
      visit merchant_items_path(@merchant_1)
      
      expect(page).to have_content("Ball")
      expect(page).to have_content("Disc")
    end
    
    it "doesn't display items for any other merchant" do
      visit merchant_items_path(@merchant_1)
      
      expect(page).to_not have_content("pants")
    end
  end
  
  # 9. Merchant Item Disable/Enable
  # As a merchant
  # When I visit my items index page (/merchants/:merchant_id/items)
  # Next to each item name I see a button to disable or enable that item.
  # When I click this button
  # Then I am redirected back to the items index
  # And I see that the items status has changed
  
  describe "when I visit my items index page" do
    it "displays a button next to each item to enable/disable that item" do
      visit merchant_items_path(@merchant_1)
      
      expect(page).to have_button("Disable")
    end
    
    it "redirects me back to my items index page and I see the status of that item has changed" do
      visit merchant_items_path(@merchant_1)

      within("div#enabled_items") do
        item_div = find("div", text: "Ball")
        within(item_div) do
          click_button "Disable"
        end
      end

      expect(page).to have_current_path(merchant_items_path(@merchant_1))
      expect(page).to have_button("Enable")
      expect(page).to have_text("Item successfully disabled.")
    end
  end

# 10. Merchant Items Grouped by Status
# As a merchant,
# When I visit my merchant items index page
# Then I see two sections, one for "Enabled Items" and
# one for "Disabled Items"
# And I see that each Item is listed in the appropriate section

    describe "when i visit merchant items index page" do
      it "displays an enabled and disabled item section" do
        visit merchant_items_path(@merchant_1)
      
        expect(page).to have_selector("div#enabled_items")
        expect(page).to have_selector("div#disabled_items")
      end
    
      it "displays each item listed in that items appropriate section" do
        visit merchant_items_path(@merchant_1)
      
        within("div#enabled_items") do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
      end
    
      within("div#disabled_items") do
      expect(page).to have_content(@item_4.name)
    end
  end
end

# 11. Merchant Item Create
# As a merchant
# When I visit my items index page
# I see a link to create a new item.
# When I click on the link,
# I am taken to a form that allows me to add item information.
# When I fill out the form I click ‘Submit’
# Then I am taken back to the items index page
# And I see the item I just created displayed in the list of items.
# And I see my item was created with a default status of disabled.

  describe "when i visit my items index page" do
    it "displays a link to create a new item and when clicked takes me to a form to add item info" do
      visit merchant_items_path(@merchant_1)

      click_link "Create New Item"

      expect(page).to have_current_path(new_merchant_item_path(@merchant_1))
      expect(page).to have_selector("form")
    end

    it "takes me back to the items index page after the form has been filled out and submit has been clicked" do
      visit new_merchant_item_path(@merchant_1)

      fill_in "Name", with: "Goo"
      fill_in "Description", with: "Gooey"
      fill_in "Unit price", with: 1000

      click_button "Submit"

      expect(page).to have_current_path(merchant_items_path(@merchant_1))
    end

    it "displays the newly created item in the appropriate section with a default status of disabled" do
      visit new_merchant_item_path(@merchant_1)

      fill_in "Name", with: "Goo"
      fill_in "Description", with: "Gooey"
      fill_in "Unit price", with: 1000

      click_button "Submit"
      
      within("#disabled_items") do
        expect(page).to have_content("Goo")
        expect(Item.last.disabled?).to eq(true)
      end
    end
  end

# 12. Merchant Items Index: 5 most popular items
# As a merchant
# When I visit my items index page
# Then I see the names of the top 5 most popular items 
# ranked by total revenue generated
# And I see that each item name links to my merchant item show page for that item
# And I see the total revenue generated next to each item name
# Notes on Revenue Calculation:
# - Only invoices with at least one successful transaction should count towards revenue
# - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
# - Revenue for an invoice item should be calculated as the 
# - invoice item unit price multiplied by the quantity (do not use the item unit price)

  describe "when i visit my items index page" do
    it "displays the name of the top 5 most popular items ranked by total revenue generated" do
      visit merchant_items_path(@merchant_1)
      
      top_items = Item.top_popular_items(@merchant_1.id)
      
      within("#top_items") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(top_items[0].name)
      expect(page).to have_content(top_items[1].name)
      expect(page).to have_content(top_items[2].name)
      expect(page).to have_content(top_items[3].name)
      expect(page).to have_content(top_items[4].name)
      expect(page).to have_content(21600)
      expect(page).to have_content(18000)
      expect(page).to have_content(17600)
      expect(page).to have_content(12000)
      expect(page).to have_content(10000)
    end
  end
end

# 13. Merchant Items Index: Top Item's Best Day
# As a merchant
# When I visit my items index page
# Then next to each of the 5 most popular items 
# I see the date with the most sales for each item.
# And I see a label “Top selling date for <item name> was <date with most sales>"
# Note: use the invoice date. If there are multiple days with equal number of sales, 
# return the most recent day.

  describe "when i visit my items index page" do
    describe "date next to top 5 popular items" do
      it "displays a label 'Top selling date for <item name> was <date with most sales>'" do
        visit merchant_items_path(@merchant_1)

        top_items = Item.top_popular_items(@merchant_1.id)

        item_dates = top_items.map { |item| item.most_sales_date }.sort.reverse
        #will this test work when the dates changes because items and invoices get created again?
        expect(page).to have_content("Top selling date for #{top_items[0].name} was #{item_dates[0].strftime('%Y-%m-%d')}")
        expect(page).to have_content("Top selling date for #{top_items[1].name} was #{item_dates[1].strftime('%Y-%m-%d')}")
        expect(page).to have_content("Top selling date for #{top_items[2].name} was #{item_dates[2].strftime('%Y-%m-%d')}")
        expect(page).to have_content("Top selling date for #{top_items[3].name} was #{item_dates[3].strftime('%Y-%m-%d')}")
        expect(page).to have_content("Top selling date for #{top_items[4].name} was #{item_dates[4].strftime('%Y-%m-%d')}")
      end
    end
  end
end