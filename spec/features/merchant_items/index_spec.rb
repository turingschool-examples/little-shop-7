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
end
