require "rails_helper"

RSpec.describe "As a merchant" do
  before :each do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)
    @item = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    @item3 = create(:item, merchant: @merchant)
    @item4 = create(:item, merchant: @merchant2)
    @item5 = create(:item, merchant: @merchant2)
  end
  describe "UserStory 9" do
    # And I see that the items status has changed
    describe "When I visit my items index page" do

      visit "/merchants/#{merchant.id}/items"

      expect(page).to have_button("Disable")

      click_button("Disable")
    

      expect(current_path).to eq("/merchants/#{merchant.id}/items")
      expect(page)
    end
  end
end