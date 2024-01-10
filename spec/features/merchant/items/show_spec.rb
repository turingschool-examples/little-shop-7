require "rails_helper"

RSpec.describe "MerchantItem index", type: :feature do
    before(:each) do
        @merchant_1 = Merchant.create(name: "Chucky Cheese")
        @item_1 = @merchant_1.items.create(name: "Moldy Cheese", description: "ew", unit_price: 1199, merchant_id: @merchant_1.id)

        @merchant_2 = Merchant.create(name: "McDonalds")
        @item_2 = @merchant_2.items.create(name: "Big Mac", description: "Juicy", unit_price: 29, merchant_id: @merchant_2.id)
    end

    it "7. Merchant Items Show Page" do
        # (merchants/:merchant_id/items)
        visit "/merchants/#{@merchant_1.id}/items"
        # When I click on the name of an item from the merchant items index page,
        click_on("Moldy Cheese")
        # Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)
        expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
        # And I see all of the item's attributes including: Name, Description, Current Selling Price
        expect(page).to have_content("Moldy Cheese")
        expect(page).to have_content("ew")
        expect(page).to have_content("1199")
    end
end
