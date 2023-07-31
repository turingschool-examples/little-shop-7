require "rails_helper"

RSpec.describe "Merchant Indes Page" do
  before :each do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)
    @item = create(:item, merchant: @merchant)
    @item2 = create(:item, merchant: @merchant)
    @item3 = create(:item, merchant: @merchant)
    @item4 = create(:item, merchant: @merchant2)
    @item5 = create(:item, merchant: @merchant2)
  end
  describe "User Story 6" do
    #User Story 6
    it "displays a list of only the merchants items" do
      
      visit "/merchants/#{@merchant.id}/items"
      
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item3.name)
      expect(page).to have_no_content(@item4.name)
    end
  end
  
  

    #User Story 7
  describe "User Story 7" do
    it "reroutes and displays all of the items attributes when the item name is clicked" do
      
      visit "/merchants/#{@merchant.id}/items"

      expect(page).to have_content(@item.name)
      expect(page).to have_link(@item.name)

      click_link(@item.name)

      expect(current_path).to eq("/merchants/#{@merchant.id}/items/#{@item.id}")
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.description)
      expect(page).to have_content(@item.unit_price)
    end
  end
end