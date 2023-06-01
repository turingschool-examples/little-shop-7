require "rails_helper"

RSpec.describe "Merchant Items Index Page" do


  describe "Merchant Items Index Display", type: :feature do
    before(:each) do 
      @merchant = create(:merchant)
        @item_1 = create(:item, merchant: @merchant)
        @item_2 = create(:item, merchant: create(:merchant)) 
    end
    # User Story 6
#     As a merchant,
# When I visit my merchant items index page (merchants/:merchant_id/items)
# I see a list of the names of all of my items
# And I do not see items for any other merchant
    it "displays a list of the names of all my items" do
      visit merchants_items_path(@merchant)

      expect(page).to have_content("My Items")
      expect(page).to have_content(@item_1.name)
      expect(page).to_not have_content(@item_2.name)
    end
  end
end