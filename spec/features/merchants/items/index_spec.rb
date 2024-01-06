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
end
