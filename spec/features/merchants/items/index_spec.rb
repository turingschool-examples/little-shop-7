require "rails_helper"

RSpec.describe "Merchant Items Index Page" do


  describe "Merchant Items Index Display", type: :feature do
    before(:each) do 
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1)
      @item_2 = create(:item, merchant: @merchant_1) 
      @item_3 = create(:item, merchant: @merchant_2) 
    end
    # User Story 6
    it "displays a list of the names of all my items" do
      visit merchant_items_path(@merchant_1) #since the index page is nested under a specific merchant, need to provide the merchant_id as a parameter to generate the correct URL. The merchant_id: @merchant.id part is specifying the value for the merchant_id parameter in the URL.

      expect(page).to have_content("My Items")
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end
  end
end