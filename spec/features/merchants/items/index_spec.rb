require "rails_helper"

RSpec.describe "Merchant Items Index Page" do


  describe "Merchant Items Index Display", type: :feature do
    before(:each) do 
      @merchant = create(:merchant)
        @item_1 = create(:item, merchant: @merchant)
        @item_2 = create(:item, merchant: create(:merchant)) 
    end
    # User Story 6
    it "displays a list of the names of all my items" do
      visit merchants_items_path(merchant_id: @merchant.id) #since the index page is nested under a specific merchant, need to provide the merchant_id as a parameter to generate the correct URL. The merchant_id: @merchant.id part is specifying the value for the merchant_id parameter in the URL.
save_and_open_page
      expect(page).to have_content("My Items")
      expect(page).to have_content(@item_1.name)
      expect(page).to_not have_content(@item_2.name)
    end
  end
end