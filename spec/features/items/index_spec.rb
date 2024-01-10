require "rails_helper"

RSpec.describe "the merchant items index page" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_2.id)
  end

  describe "User Story 6" do
    # As a merchant,
    # When I visit my merchant items index page (/merchants/:merchant_id/items)
    # I see a list of the names of all of my items
    # And I do not see items for any other merchant

    it "displays my items" do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)

      visit "/merchants/#{@merchant_2.id}/items"

      expect(page).to_not have_content(@item_1.name)
      expect(page).to_not have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
    end
  end

  describe "User Story 9" do
    # As a merchant
    # When I visit my items index page (/merchants/:merchant_id/items)
    # Next to each item name I see a button to disable or enable that item.
    # When I click this button
    # Then I am redirected back to the items index
    # And I see that the items status has changed

    it "displays enable and disable buttons to update the item status" do
      visit "/merchants/#{@merchant_1.id}/items"

      expect(page).to have_button("Enable")

      click_button("Enable")

      expect(current_path).to_eq("/merchants/#{@merchant_1.id}/items")

      expect(page).to have_button("Disable")
    end
  end
end