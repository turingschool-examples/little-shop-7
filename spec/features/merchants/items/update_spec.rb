require "rails_helper"

RSpec.describe "/merchants/:id/items/:id/edit" do
  describe "As a visitor" do
    describe "When I'm directed to the edit form" do
      let!(:merchant_1) { create(:merchant) }
      let!(:item_1) { create(:item, merchant_id: merchant_1.id)}

      # User Story 8 - Merchant Item Update (display)

      it "displays a form to update the item, with the items existing information" do
        visit "/merchants/#{merchant_1.id}/items/#{item_1.id}/edit"

        fill_in("Name:", with: "The New Black")
        fill_in("Description:", with: "The Newer Black")
        fill_in("Unit Price:", with: 66666)

        click_button "Update Item"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_1.id}")

        expect(page).to have_content("Item Name: The New Black")
        expect(page).to have_content("Item Description: The Newer Black")
        expect(page).to have_content("Current Selling Price: $666.66")
        new_item = Item.find(item_1.id)
        expect(page).to have_content("Item #{new_item.name} Successfully Updated!")

        expect(page).to_not have_content("Item Name: #{item_1.name}")
        expect(page).to_not have_content("Item Description: #{item_1.description}")
        expect(page).to_not have_content("Current Selling Price: #{item_1.unit_price}")

      end
    end
  end
end