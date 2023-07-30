require "rails_helper"

RSpec.describe "Merchant Items Show Page" do
  describe "UserStory 8" do
    
    

    it "has a link of the item name" do
      @merchant = create(:merchant)
      @item = create(:item, merchant: @merchant)
      @item2 = create(:item, merchant: @merchant)
      visit "/merchants/#{@merchant.id}/items/#{@item.id}"

      expect(page).to have_link("#{@item.name} update information")

      click_on("#{@item.name} update information")
      save_and_open_page
      expect(current_path).to eq("/merchants/#{@item.merchant.id}/items/#{@item.id}")
    end
  end

end