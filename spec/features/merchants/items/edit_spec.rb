require "rails_helper"
# 8. Merchant Item Update: As a merchant, When I visit the merchant show page of an item
#  (/merchants/:merchant_id/items/:item_id) I see a link to update the item information. 
#  When I click the link Then I am taken to a page to edit this item And I see a form 
#  filled in with the existing item attribute information When I update the information in the form 
#  and I click ‘submit’ Then I am redirected back to the item show page where I see the updated information 
# And I see a flash message stating that the information has been successfully updated.#17

RSpec.describe "Merchants/Items Edit Page", type: :feature do
  it "has a link to update/edit item information on merchant item show page " do
    merchant_1 = Merchant.create!(name: "Walmart")
    merchant_2 = Merchant.create!(name: "Amazon")
    walmart_items = create_list(:item, 37, merchant_id: merchant_1.id)
    amazon_items = create_list(:item, 43, merchant_id: merchant_2.id)

    visit "/merchants/#{merchant_1.id}/items/#{walmart_items.first.id}"

    expect(page).to have_link("Update Item")

    click_link "Update Item"

    expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{walmart_items.first.id}/edit")
    expect(page).to have_selector('form#Update_Item')


    fill_in "Name", with: "Grapes"
    fill_in "Description", with: "Cool stuff"
    fill_in "Unit price", with: 1500

    click_button "Update Item"
    expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{walmart_items.first.id}")
    expect(page).to have_content("Information has been successfully updated")

    # click_link "Update Item"
    # expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{walmart_items.first.id}/edit")
    # expect(page).to have_selector('form#Update_Item')
    # fill_in "Name", with: "Round 2"
    # fill_in "Description", with: "Does this still work"
    # fill_in "Unit price", with: 5
    # click_button "Update Item"
    # expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{walmart_items.first.id}")
    # expect(page).to have_content("Information has been successfully updated")
    # save_and_open_page
  end
end