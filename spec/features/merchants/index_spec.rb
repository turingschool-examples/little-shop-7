require "rails_helper"

RSpec.describe "Merchant Indes Page" do
  describe "User Story 6" do
    #User Story 6
    it "displays a list of only the merchants items" do
      merchant = create(:merchant)
      merchant2 = create(:merchant)
      item = create(:item, merchant: merchant)
      item2 = create(:item, merchant: merchant)
      item3 = create(:item, merchant: merchant)
      item4 = create(:item, merchant: merchant2)
      item5 = create(:item, merchant: merchant2)

      visit "/merchants/#{merchant.id}/items"

      expect(page).to have_content(item.name)
      expect(page).to have_content(item3.name)
      expect(page).to have_no_content(item4.name)
    end
  end
end