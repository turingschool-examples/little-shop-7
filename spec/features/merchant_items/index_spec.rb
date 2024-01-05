require "rails_helper"

RSpec.describe "MerchantItem index", type: :feature do
    before(:each) do
        @merchant_1 = Merchant.create(name: "Chucky Cheese")
        @item_1 = @merchant_1.items.create(name: "Moldy Cheese", description: "ew", unit_price: 1199, merchant_id: @merchant_1.id)

        @merchant_2 = Merchant.create(name: "McDonalds")
        @item_2 = @merchant_2.items.create(name: "Big Mac", description: "Juicy", unit_price: 29, merchant_id: @merchant_2.id)
    end

    it "User Story 6. Merchant Items Index Page" do
        # When I visit my merchant items index page (merchants/:merchant_id/items)
        visit "/merchants/#{@merchant_1.id}/items"
        # I see a list of the names of all of my items
        expect(page).to have_content("Merchant Item List")
        expect(page).to have_content("Chucky Cheese's items")
        expect(page).to have_content("Moldy Cheese")
        # And I do not see items for any other merchant
        expect(page).to_not have_content("Big Mac")
    end

    it "8. Merchant Item Update" do
        # When I visit the merchant show page of an item
        visit "/merchants/#{@merchant_1.id}/items/#{@item_1.id}"
        # I see a link to update the item information.
        expect(page).to have_content("Update item information")
        # When I click the link
        click_on("Update item information")
        # Then I am taken to a page to edit this item
        expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/#{@item_1.id}/edit")
        # And I see a form filled in with the existing item attribute information
        expect(page).to have_content("Moldy Cheese")
        expect(page).to have_content("ew")
        expect(page).to have_content("1199")
        # When I update the information in the form and I click ‘submit’
        fill_in "New name", with: "Cheese Pizza"
        fill_in "New description", with: "Scrumptious!"
        fill_in "New price", with: "1899"
        expect(page).to have_content("Submit")
        click_on("Submit")
        # Then I am redirected back to the item show page where I see the updated information
        expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
        expect(page).to have_content("Cheese Pizza")
        expect(page).to have_content("Scrumptious!")
        expect(page).to have_content("1899")
        # And I see a flash message stating that the information has been successfully updated.
        expect(page).to have_content("Update successful!")
    end
end
