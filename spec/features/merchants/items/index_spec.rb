require "rails_helper"

RSpec.describe "/merchants/:merchant_id/items" do
  describe "As a visitor" do
    describe "when I visit a merchants items index page" do
      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant) }

      let!(:item_1) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:item_2) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:item_3) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:item_4) { create(:item, merchant_id: merchant_2.id, status: 0)}

      # User Story 6 - Merchant Items Index Page

      it "displays a list of names of all that merchants items" do
        visit "/merchants/#{merchant_1.id}/items"
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_3.name)
        expect(page).to_not have_content(item_4.name)

        visit "/merchants/#{merchant_2.id}/items"
        expect(page).to have_content(item_4.name)
        expect(page).to_not have_content(item_1.name)
        expect(page).to_not have_content(item_2.name)
        expect(page).to_not have_content(item_3.name)
      end

      # User Story 7 - Merchant Items Show Page (links from index)

      it "links to the items show page when I click on the item name" do
        visit "/merchants/#{merchant_1.id}/items"
        click_link "#{item_1.name}"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_1.id}")
        expect(current_path).to_not eq("/merchants/#{merchant_1.id}/items/#{item_2.id}")

        visit "/merchants/#{merchant_1.id}/items"
        click_link "#{item_2.name}"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_2.id}")
      end

      # User Story 9/10 - Merchant Item Disable/Enable

      it "displays a button that will enable or disable each item" do
        visit "/merchants/#{merchant_1.id}/items"
        within ".enabled-items" do
          expect(page).to have_content("Enabled Items")
          expect(page).to have_link(item_1.name)
          expect(page).to have_link(item_2.name)
          expect(page).to have_link(item_3.name)

          expect(page).to have_button("Disable #{item_1.name}")
          expect(page).to have_button("Disable #{item_2.name}")
          expect(page).to have_button("Disable #{item_3.name}")

          click_button "Disable #{item_1.name}"
        end

        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")

        within ".disabled-items" do
          expect(page).to have_content("Disabled Items")
          expect(page).to have_link(item_1.name)
          expect(page).to_not have_content(item_2.name)
          expect(page).to_not have_content(item_3.name)

          expect(page).to have_button("Enable #{item_1.name}")
          expect(page).to_not have_button("Disable #{item_2.name}")
          expect(page).to_not have_button("Disable #{item_3.name}")
        end

        within ".enabled-items" do
          expect(page).to_not have_link(item_1.name)
          expect(page).to_not have_button("Disable #{item_1.name}")
        end
      end

      # User Story 11 - Merchant Item Create (link)

      it "has a link to create a new item" do
        visit "/merchants/#{merchant_1.id}/items"
        click_link "Create New Item"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items/new")
      end
    end
  end
end