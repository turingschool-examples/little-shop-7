require 'rails_helper'

RSpec.describe "MerchantItems Index", type: :feature do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @item_4 = create(:item, merchant_id: @merchant_1.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)
    @item_6 = create(:item, merchant_id: @merchant_2.id)
    @item_7 = create(:item, merchant_id: @merchant_2.id)
    @item_8 = create(:item, merchant_id: @merchant_2.id)
    @item_9 = create(:item, merchant_id: @merchant_2.id)
  end

  describe "When I visit the merchantitems index page" do
    it "I see a list of all items associated with the current merchant, without items for other merchants" do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_4.name)
      expect(page).to_not have_content(@item_5.name)
      expect(page).to_not have_content(@item_6.name)
      expect(page).to_not have_content(@item_7.name)
      expect(page).to_not have_content(@item_8.name)
      expect(page).to_not have_content(@item_9.name)
    end

    it "each listed item links to that items show page" do
      visit "/merchants/#{@merchant_1.id}/items"

      within("#item-#{@item_1.id}") do
        expect(page).to have_link("#{@item_1.name}", href: "/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
        click_link("#{@item_1.name}")
      end

      expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items/#{@item_1.id}")
    end

    it "each item has a button to enable or disable it, and clicking it performs that action" do
      visit "/merchants/#{@merchant_1.id}/items"

      within("#item-#{@item_1.id}") do
        expect(page).to have_button("Disable Item")
        click_button("Disable Item")
      end

      expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")

      within("#item-#{@item_1.id}") do
        expect(page).to have_button("Enable Item")
        click_button("Enable Item")
      end

      expect(page).to have_current_path("/merchants/#{@merchant_1.id}/items")

      within("#item-#{@item_1.id}") do
        expect(page).to have_button("Disable Item")
      end
    end
  end
end