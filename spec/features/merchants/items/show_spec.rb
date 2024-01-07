require "rails_helper"

RSpec.describe "Merchants Items Show Page", type: :feature do
  it "shows the item's attributes including name, description and current price" do
    merchant_1 = Merchant.create!(name: "Walmart", status: :enabled)
    walmart_items = create_list(:item, 3, merchant_id: merchant_1.id)

    visit "/merchants/#{merchant_1.id}/items"

    expect(page).to have_content(walmart_items.first.name)
    expect(page).to have_link(walmart_items.first.name, href: "/merchants/#{merchant_1.id}/items/#{walmart_items.first.id}")

    click_link walmart_items.first.name

    expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{walmart_items.first.id}")

    expect(page).to have_content("#{walmart_items.first.name} info")
    expect(page).to have_content("Description: #{walmart_items.first.description}")
    expect(page).to have_content("Unit Price: #{walmart_items.first.unit_price}")
  end
end
