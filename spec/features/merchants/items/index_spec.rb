require "rails_helper"
# Merchant Items Index Page: As a merchant, When I visit my merchant items index page
# (merchants/:merchant_id/items) I see a list of the names of all of my items
# And I do not see items for any other merchant
RSpec.describe "Merchants/Items Index Page", type: :feature do
  it "shows a list of all of my items and not for other merchants" do
    merchant_1 = Merchant.create!(name: "Walmart")
    merchant_2 = Merchant.create!(name: "Amazon")
    walmart_items = create_list(:item, 37, merchant_id: merchant_1.id)
    amazon_items = create_list(:item, 43, merchant_id: merchant_2.id)

    visit "/merchants/#{merchant_1.id}/items"

    walmart_items.each do |walmart_item|
      expect(page).to have_content(walmart_item.name)
    end

    amazon_items.each do |amazon_item|
      expect(page).to_not have_content(amazon_item.name)
    end

    visit "/merchants/#{merchant_2.id}/items"

    amazon_items.each do |amazon_item|
      expect(page).to have_content(amazon_item.name)
    end

    walmart_items.each do |walmart_item|
      expect(page).to_not have_content(walmart_item.name)
    end
  end

  it "has a disable/enable status and a link to change status next to each item" do
    # 9. Merchant Item Disable/Enable: As a merchant When I visit my items index page 
    # (/merchants/:merchant_id/items) Next to each item name I see a button to disable 
    # or enable that item. When I click this button Then I am redirected back to the items index 
    # And I see that the items status has changed

    merchant_1 = Merchant.create!(name: "Walmart")
    merchant_2 = Merchant.create!(name: "Amazon")
    walmart_items = create_list(:item, 37, merchant_id: merchant_1.id)
    amazon_items = create_list(:item, 43, merchant_id: merchant_2.id)

    visit "/merchants/#{merchant_1.id}/items"

    within "#item-#{merchant_1.items.first.id}" do 
      expect(page).to have_content("enabled")
      expect(page).to have_button("enable")
      expect(page).to have_button("disable")
    end

    within "#item-#{merchant_1.items.last.id}" do 
      expect(page).to have_content("enabled")
      expect(page).to have_button("enable")
      expect(page).to have_button("disable")

      click_button "disable"
    end

    expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
    within "#item-#{merchant_1.items.last.id}" do 
      expect(page).to have_content("disabled")
    end

  end

end
