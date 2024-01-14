require "rails_helper"

RSpec.describe "MerchantItem index", type: :feature do
    before(:each) do
        @merchant_1 = Merchant.create(name: "Chucky Cheese")
        @item_1 = @merchant_1.items.create(name: "Moldy Cheese", description: "ew", unit_price: 1199, merchant_id: @merchant_1.id)

        @merchant_2 = Merchant.create(name: "McDonalds")
        @item_2 = @merchant_2.items.create(name: "Big Mac", description: "Juicy", unit_price: 29, merchant_id: @merchant_2.id)
        @item_3 = @merchant_2.items.create(name: "Chicken Nuggets", description: "Vegan", unit_price: 15, merchant_id: @merchant_2.id)
    end

    it "11. Merchant Item Create" do
        # When I visit my items index page
        visit "/merchants/#{@merchant_1.id}/items"
        # I see a link to create a new item.
        expect(page).to have_content("Create new item")
        # When I click on the link,
        click_on("Create new item")
        # I am taken to a form that allows me to add item information.
        expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/new")
        expect(page).to have_field("Name")
        expect(page).to have_field("Description")
        expect(page).to have_field("Price")
        # When I fill out the form I click ‘Submit’
        fill_in "Name", with: "Cheese Pizza"
        fill_in "Description", with: "Scrumptious!"
        fill_in "Price", with: "1899"
        expect(page).to have_button("Submit")
        click_on("Submit")
        # Then I am taken back to the items index page
        expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")
        # And I see the item I just created displayed in the list of items.
        # And I see my item was created with a default status of disabled.
        within '.disabled-items' do
            expect(page).to have_content("Cheese Pizza")
        end
    end

    it "11. Merchant Item Create [SAD PATH]" do
        # When I visit my items index page
        visit "/merchants/#{@merchant_1.id}/items"
        # I see a link to create a new item.
        expect(page).to have_content("Create new item")
        # When I click on the link,
        click_on("Create new item")
        # I am taken to a form that allows me to add item information.
        expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/new")
        expect(page).to have_field("Name")
        expect(page).to have_field("Description")
        expect(page).to have_field("Price")
        # When I fill out the form I click ‘Submit’
        fill_in "Name", with: ""
        fill_in "Description", with: ""
        fill_in "Price", with: ""
        expect(page).to have_button("Submit")
        click_on("Submit")
        # Then I am taken back to the items index page
        expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")
        # And I see the item I just created displayed in the list of items.
        # And I see my item was created with a default status of disabled.
        within '.disabled-items' do
            expect(page).to_not have_content("Cheese Pizza")
        end
    end
end