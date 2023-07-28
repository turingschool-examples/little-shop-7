require "rails_helper"

RSpec.describe "items index page", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    @merchant_2 = Merchant.create!(name: "John Johnson", status: nil)
    @item_1 = @merchant_1.items.create!(name: "Ball", description: "round", unit_price: 75106, status: 1)
    @item_2 = @merchant_1.items.create!(name: "Disc", description: "flat", unit_price: 75103, status: 1)
    @item_3 = @merchant_2.items.create!(name: "Pants", description: "soft", unit_price: 65104, status: 1)
    @item_4 = @merchant_1.items.create!(name: "Stick", description: "long", unit_price: 30100, status: 0)
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
      
      expect(page).to have_button("Disable", count: 2)
    end
    
    it "redirects me back to my items index page and I see the status of that item has changed" do
      visit merchant_items_path(@merchant_1)

      within(".item", text: @item_1.name) do
        click_button "Disable"
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
end