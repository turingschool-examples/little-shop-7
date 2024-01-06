require "rails_helper"

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
  end
end
