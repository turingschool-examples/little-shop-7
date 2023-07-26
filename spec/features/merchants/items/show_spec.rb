require "rails_helper"

RSpec.describe "items show page", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
    @merchant_2 = Merchant.create!(name: "John Johnson", status: nil)
    @item_1 = @merchant_1.items.create!(name: "Ball", description: "round", unit_price: 75106, status: nil)
    @item_2 = @merchant_1.items.create!(name: "Disc", description: "flat", unit_price: 75103, status: nil)
    @item_3 = @merchant_2.items.create!(name: "Pants", description: "soft", unit_price: 65104, status: nil)
  end


# 7. Merchant Items Show Page
# As a merchant,
# When I click on the name of an item from the merchant items index page, (merchants/:merchant_id/items)
# Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)
# And I see all of the item's attributes including:
# Name
# Description
# Current Selling Price
  describe "when I click on a merchants item" do
    it "takes me to that items show page" do
      visit merchant_items_path(@merchant_1)

      click_link "Ball"

      expect(page).to have_current_path(merchant_item_path(@merchant_1, @item_1))
    end

    it "displays that items name, description and current selling price" do
      visit merchant_item_path(@merchant_1, @item_1)
      
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.formatted_unit_price)
    end
  end
end